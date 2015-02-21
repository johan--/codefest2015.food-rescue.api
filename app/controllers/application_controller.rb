class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # acts_as_token_authentication_handler_for User

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
end
