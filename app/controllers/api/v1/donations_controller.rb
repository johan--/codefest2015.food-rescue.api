class Api::V1::DonationsController < ApplicationController
  before_action :verify_authentication_token!

  before_action :set_donation, only: [:show ]

  def index
    render json: current_user.donations
  end

  def show
    render json: @donation.to_json(include: [:recipient, :driver, :donor])
  end

  def create
    @donation = current_user.donations.create!(donation_params)

    if @donation.id
      @donation.recipient = Recipient.first
      @donation.save!
    end

    render json: @donation
  end

  def start_donation
    donation = current_user.donation.find(params[:id])
    donation.start!
  end

  def verify_driver_to_donor_handshake
    donation = current_user.donation.find(params[:id])

    if donation.driver_to_donor_handshake == params[:hash]
      if Digest::SHA1.hexdigest(donation.id.to_s + 'donor-handshake') == params[:hash]
        donation.arrived_at_donor!
        render json: donation
      else
        render json: { success: false }
      end
    else
      render json: { success: false }
    end
  end

  def verify_donor_to_recipient_handshake
    donation = current_user.donation.find(params[:id])

    if donation.donor_to_recipient_handshake  == params[:hash]
      if Digest::SHA1.hexdigest(donation.id.to_s + 'recipient-handshake') == params[:hash]
        donation.complete!
        render json: donation
      else
        render json: { success: false }
      end
    else
      render json: { success: false }
    end
  end

  def past_donations
    render json: current_user.donations.has_been_completed
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
    params[:donation].permit(
      :name, :description, :weight,
      :special_instructions, :donor_id,
      :dimensions, :driver_id, :recipient_id
    )
  end

  def set_donation
    @donation = Donation.find(params[:id])
  end

end
