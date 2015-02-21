class Api::V1::DriversController < ApplicationController
  before_action :verify_authentication_token!

  def index
    render json: current_user.to_json(methods: [:possible_jobs])
  end

  def update
    current_user.update(driver_params)
    render json: current_user
  end


  private

  def driver_params
    params[:driver].permit(
      :first_name, :last_name,
      :license_plate_number, :zipcode,
      :city, :state, :drivers_license_number,
      :car_type, :car_make, :car_model, :car_year,
      :driver_photo, :car_photo)
  end
end
