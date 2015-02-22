class Donor < User
  has_many :donations

  attr_accessor :distance

  def calc_distance(loc1, loc2)
    rad_per_deg = Math::PI/180  # PI / 180
    rkm = 6371                  # Earth radius in kilometers
    rm = rkm * 1000             # Radius in meters

    dlat_rad = (loc2.lat-loc1.lat) * rad_per_deg  # Delta, converted to rad
    dlon_rad = (loc2.lng-loc1.lng) * rad_per_deg

    lat1_rad, lon1_rad = [ loc1.lat, loc1.lng ]
    lat2_rad, lon2_rad = [ loc2.lat, loc2.lng ]

    a = Math.sin(dlat_rad/2)**2 + Math.cos(lat1_rad) * Math.cos(lat2_rad) * Math.sin(dlon_rad/2)**2
    c = 2 * Math::atan2(Math::sqrt(a), Math::sqrt(1-a))

    ( (rm * c) / 1000 ) * 0.621371# Delta in meters
  end

end
