class Driver < User

  def possible_donations
    Donation.all
  end
end
