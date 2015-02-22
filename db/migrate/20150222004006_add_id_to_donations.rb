class AddIdToDonations < ActiveRecord::Migration
  def change
    add_column :donations, :driver_id, :integer
    add_column :donations, :recipent_id, :integer
  end
end
