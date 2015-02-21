class Api::V1::ZipcodeController < ApplicationController
  def show
    address = Address.new(zipcode: params[:id])
    render json: address.fetch
  end
end
