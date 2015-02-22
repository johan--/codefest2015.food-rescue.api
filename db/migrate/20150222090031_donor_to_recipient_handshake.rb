class DonorToRecipientHandshake < ActiveRecord::Migration
  def change
    rename_column :donations, :donor_to_recipient_handshake, :driver_to_recipient_handshake
  end
end
