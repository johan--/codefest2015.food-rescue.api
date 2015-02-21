class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token

  def verify_authentication_token!
    authenticate_or_request_with_http_basic do |user_name, token|
      user = User.find_for_database_authentication(email: user_name)

      if user.authentication_token != token
        warden.custom_failure!
        render :json => { :errors => ["Unauthorized"] },  :success => false, :status => :unauthorized
      end

      return true
    end
  end

  def current_user
    @current_user ||= authenticate_or_request_with_http_basic do |user_name, token|
      if user_name
        User.find_by(email: user_name)
      else
        nil
      end
    end
  end
end
