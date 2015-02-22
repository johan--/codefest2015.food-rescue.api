class Api::V1::DonationsController < ApplicationController
  before_action :verify_authentication_token!
  before_action :verify_donor

  before_action :set_donation, only: [:show, :update, :delete ]

  def index
    render json: current_user.donations
  end

  def show
    render json: @donation
  end

  def create
    @donation = current_user.donations.create!(donation_params)
    render json: @donation
  end

  def update
    @donation.update(donation_params)
    render json: @donation
  end

  def destroy
    render json: @donation.delete
  end

  private

  def donation_params
    params[:donation].permit!
  end

  def set_donation
    @donation = current_user.donations.find(params[:id])
  end

  def verify_donor
    yield unless current_user.type == 'Donor'
  end

end
