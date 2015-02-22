class Api::V1::DriversController < ApplicationController
  before_action :verify_authentication_token!

  def index
    current_user.origin = params[:origin] || current_user.zipcode

    render json: current_user.to_json(methods: [:possible_donations])
  end

  def update
    current_user.update(driver_params)
    render json: current_user
  end

  def current_donations
    donations = current_user.donations.where(completed: false)
    render json: donations
  end


  private

  def driver_params
    params[:driver].permit(
      :first_name, :last_name,
      :license_plate_number,
      :address_1, :address_2, :phone_number,
      :zipcode, :city, :state, :drivers_license_number,
      :car_type, :car_make, :car_model, :car_year,
      :driver_photo, :car_photo)
  end
end
