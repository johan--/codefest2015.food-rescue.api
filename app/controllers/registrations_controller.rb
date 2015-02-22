class RegistrationsController < Devise::RegistrationsController
  respond_to :json

  def create
    build_resource

    resource.email = params[:email]
    resource.password = params[:password]
    resource.type = params[:type]

    if resource.save
      if resource.active_for_authentication?
        resource.ensure_authentication_token!  #make sure the user has a token generated
        render :json => {
          user: resource,
          user_type: resource.type
        }, :status => :created
      else
        resource.ensure_authentication_token!  #make sure the user has a token generated
        render :json => {
          user: resource,
          user_type: resource.type
        }, :status => :created
      end
    else
      clean_up_passwords resource
      return render :json => {:success => false}
    end
  end
end
