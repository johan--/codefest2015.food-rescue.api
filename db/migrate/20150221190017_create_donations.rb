class CreateDonations < ActiveRecord::Migration
  def change
    create_table :donations do |t|
      t.string :name
      t.text :description
      t.string :weight
      t.text :special_instructions
      t.references :donor
      t.string :dimensions

      t.timestamps null: false
    end
  end
end
