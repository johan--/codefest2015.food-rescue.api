class Api::V1::DonationsController < ApplicationController
  before_action :verify_authentication_token!
  before_action :set_donation, only: [:update]

  def index
    render json: current_user.donations
  end

  def create
    puts("==============")
    puts current_user.inspect
    puts("==============")

    @donation = current_user.donations.create!(donation_params)
    render json: @donation
  end

  def update
    @donation.update(donation_params)
    render json: @donation
  end

  private

  def donation_params
    params[:donation].permit!
  end

  def set_donation
    @donation = current_user.donations.find(params[:id])
  end

end
