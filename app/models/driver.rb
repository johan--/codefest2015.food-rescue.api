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
          id: donation.id,
          name: donation.name,
          description: donation.description,
          weight: donation.weight,
          special_instructions: donation.special_instructions,
          recipient: donation.recipient,
          donor: donor,
          dimensions: donation.dimensions,
          distance: donor.calc_distance(donor, self) + donor.calc_distance(donor, donation.recipient) + donor.calc_distance(donation.recipient, self)
        }
      end
    end

    donations_json.sort_by { |donation| donation[:distance] }
  end
end
