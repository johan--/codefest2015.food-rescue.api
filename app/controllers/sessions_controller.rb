class SessionsController < Devise::SessionsController
  skip_before_filter :verify_authenticity_token,
                     :if => Proc.new { |c| c.request.format == 'application/json' }

  respond_to :json

  def create
    resource = User.find_for_database_authentication(:email => params[:email])
    return invalid_login_attempt unless resource

    if resource.valid_password?(params[:password])
        resource.device_id = params[:device_id]
        resource.ensure_authentication_token!  #make sure the user has a token generated
        render :json => {
          user: resource,
          user_type: resource.type
        }, :status => :created
    else
      return invalid_login_attempt
    end
  end

  def destroy
    # expire auth token
    user = User.where(:authentication_token=>params[:auth_token]).first
    user.device_id = nil
    user.reset_authentication_token!
    render :json => { :message => ["Session deleted."] },  :success => true, :status => :ok
  end

  def invalid_login_attempt
      warden.custom_failure!
      render :json => { :errors => ["Invalid email or password."] },  :success => false, :status => :unauthorized
  end
end
