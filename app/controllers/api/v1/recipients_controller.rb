class Api::V1::RecipientsController < ApplicationController
  before_action :verify_authentication_token!

  def index
    render json: current_user
  end

  def update
    current_user.update(recipients_params)
    render json: current_user
  end


  private

  def recipients_params
    params[:recipients].permit!
  end
end

