class Api::V1::UsersController < ApplicationController
  before_action :verify_authentication_token!


  def update
    render json: current_user.update(user_params)
  end

  private

  def user_params
    params[:user].permit(:type)
  end

end
