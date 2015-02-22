class AddHashesToDonation < ActiveRecord::Migration
  def change
    add_column :donations, :driver_to_donor_handshake, :string
    add_column :donations, :donor_to_recipient_handshake, :string
  end
end
