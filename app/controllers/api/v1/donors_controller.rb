class Api::V1::DonorsController < ApplicationController
  before_action :verify_authentication_token!

  def index
    render json: current_user
  end

  def update
    current_user.update(donor_params)
    render json: current_user
  end


  private

  def donor_params
    params[:donor].permit!
  end
end

