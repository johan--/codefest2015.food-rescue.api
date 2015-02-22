class Driver < User
  has_many :donations


  attr_accessor :origin, :distance

  def possible_donations
    donations_json = []
    sql = Donor.by_distance(origin: [self.lat, self.lng]).to_sql

    ActiveRecord::Base.connection.select_all(sql).each do |donor|
      donor = Donor.find(donor["id"])

      Donation.where(donor_id: donor["id"]).each do |donation|
        donations_json << {
          name: donation.name,
          description: donation.description,
          weight: donation.weight,
          special_instructions: donation.special_instructions,
          recipient: donation.recipient,
          donor: {
            id: donor.id,
            address_1: donor.address_1,
            address_2: donor.address_2,
            city: donor.city,
            state: donor.state,
            zipcode: donor.zipcode,
            phone_number: donor.phone_number
          },
          dimensions: donation.dimensions,
          distance: donor.calc_distance(donor, self) + donor.calc_distance(donor, donation.recipient) + donor.calc_distance(donation.recipient, self)
        }
      end
    end

    donations_json.sort_by { |donation| donation[:distance] }
  end
end
