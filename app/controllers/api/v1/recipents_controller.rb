class Api::V1::RecipentsController < ApplicationController
  before_action :verify_authentication_token!

  def index
    render json: current_user
  end

  def update
    current_user.update(recipents_params)
    render json: current_user
  end


  private

  def recipents_params
    params[:recipent].permit!
  end
end

