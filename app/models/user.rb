class User < ActiveRecord::Base
  # acts_as_token_authenticatable

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :token_authenticatable

      # :first_name, :last_name,
      # :license_plate_number, :zipcode,
      # :city, :state,
end
