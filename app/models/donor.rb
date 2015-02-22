class Donor < User
  has_many :donations

  attr_accessor :distance
end
