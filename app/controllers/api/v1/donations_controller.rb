class Api::V1::DonationsController < ApplicationController
  before_action :verify_authentication_token!

  before_action :set_donation, only: [:show ]

  def index
    render json: current_user.donations
  end

  def show
    render json: @donation
  end

  def create
    @donation = current_user.donations.create!(donation_params.merge(recipient: Recipient.first))
    render json: @donation
  end

  def update
    @donation = current_user.donations.find(params[:id])
    @donation.update(donation_params)
    render json: @donation
  end

  def destroy
    @donation = current_user.donations.find(params[:id])
    render json: @donation.delete
  end

  private

  def donation_params
    params[:donation].permit!
  end

  def set_donation
    @donation = Donation.find(params[:id])
  end

end
