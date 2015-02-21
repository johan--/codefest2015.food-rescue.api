class ApplicationController < ActionController::Base
  before_action :set_headers_for_ionic



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

  def set_headers_for_ionic
    response.headers("Access-Control-Allow-Origin", "*");
  end
end
