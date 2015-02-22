class AddImageToDonation < ActiveRecord::Migration
  def change
    add_column :donations, :image, :text
  end
end
