class Api::V1::DonorsController < ApplicationController
  before_action :authenticate_user!

  def index
    render json: current_user
  end

  def update
    current_user.update(drive_params)
    render json: current_user
  end


  private

  def driver_params
    params[:donor].permit!
  end
end

