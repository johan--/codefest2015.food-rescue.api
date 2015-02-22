class AddCompletedTimestamp < ActiveRecord::Migration
  def change
    add_column :donations, :completd_at, :datetime
  end
end
