class TypoFix < ActiveRecord::Migration
  def change
    rename_column :donations, :completd_at, :completed_at
  end
end
