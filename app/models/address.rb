require 'net/http'

class Address
  include ActiveModel::Model

  attr_accessor :zipcode, :city, :state

  validates_presence_of :zipcode
  validates :zipcode, zipcode: { country_code: :us }

  URL_TEMPLATE = URI.escape('http://zip.getziptastic.com/v2/US/')

  def fetch
    if self.valid?
      response = Net::HTTP.get_response(URI.parse(zipcode_url))
      body = JSON.parse(response.body)
      { city: body["city"], state: body["state_short"]}
    else
      raise ActiveModel::RecordInvalid
    end
  end

  private

  def zipcode_url
    URL_TEMPLATE + self.zipcode
  end
end
