class CreateDrivers < ActiveRecord::Migration
  def change
    create_table :drivers do |t|
      t.string :fname
      t.string :lname
      t.string :email
      t.string :license_plate_no
      t.string :drivers_license_no

      t.timestamps null: false
    end
  end
end
