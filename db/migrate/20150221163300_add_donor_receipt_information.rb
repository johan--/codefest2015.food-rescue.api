class AddDonorReceiptInformation < ActiveRecord::Migration
  def change
    add_column :users, :organization_name, :string
    add_column :users, :address_1, :string
    add_column :users, :address_2, :string
    add_column :users, :phone_number, :string
    add_column :users, :special_instructions, :text
  end
end
