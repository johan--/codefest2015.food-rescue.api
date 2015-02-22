require 'geokit'

class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :token_authenticatable

  acts_as_mappable

  before_update :geocode_by

  def full_street_address
    "#{address_1} #{city} #{state} #{zipcode}"
  end

  private

  def geocode_by
    if self.address_1_changed? || self.city_changed? || self.state_changed? || self.zipcode_changed?
      loc = Geokit::Geocoders::MultiGeocoder.geocode(self.full_street_address)
      if loc.success
        self.lat = loc.lat
        self.lng = loc.lng
        self.update_columns(lat: loc.lat, lng: loc.lng)
      end
    end
  end
end
