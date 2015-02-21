class AddColumnsToDrivers < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :license_plate_number, :string
    add_column :users, :zipcode, :string
    add_column :users, :city, :string
    add_column :users, :state, :string
    add_column :users, :drivers_license_number, :string
    add_column :users, :car_type, :string
    add_column :users, :car_make, :string
    add_column :users, :car_model, :string
    add_column :users, :car_year, :string
  end
end
