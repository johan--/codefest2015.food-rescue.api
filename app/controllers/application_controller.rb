class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # acts_as_token_authentication_handler_for User
    before_filter :skip_trackable

    def skip_trackable
      request.env['devise.skip_trackable'] = true
    end
end
