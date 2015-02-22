class Driver < User
  has_many :donations


  attr_accessor :origin, :distance

  def possible_donations
    donations_json = []
    sql = Donor.by_distance(origin: origin).to_sql
    result = ActiveRecord::Base.connection.execute(sql)

    puts sql
    puts result.inspect

    result.each as: :hash do |donor|
      Donation.where(donor_id: donor["id"]).each do |donation|
        donations_json << {
          name: donation.name,
          description: donation.description,
          weight: donation.weight,
          special_instructions: donation.special_instructions,
          donor: {
            id: donor["id"],
            address_1: donor["address_1"],
            address_2: donor["address_2"],
            city: donor["city"],
            state: donor["state"],
            zipcode: donor["zipcode"],
            phone_number: donor["phone_number"]
          },
          dimensions: donation.dimensions,
          distance: donor["distance"]
        }
      end
    end

    donations_json
  end
end
