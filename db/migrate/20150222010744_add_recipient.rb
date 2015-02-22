class AddRecipient < ActiveRecord::Migration
  def change
    rename_column :donations, :recipent_id, :recipient_id
  end
end
