class Donation < ActiveRecord::Base
  belongs_to :donor
  belongs_to :driver
  belongs_to :recipient


end
