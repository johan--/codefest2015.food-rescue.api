class AddCompleted < ActiveRecord::Migration
  def change
    add_column :donations, :completed, :boolean, default: false
  end
end
