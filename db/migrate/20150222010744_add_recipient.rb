class AddRecipient < ActiveRecord::Migration
  def change
    rename_column :donations, :receipt_id, :recipient_id
  end
end
