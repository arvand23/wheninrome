class CombineTables < ActiveRecord::Migration
  def change
  	drop_table :reservations

  	add_column :trips, :accepted_at, :datetime
    add_column :trips, :declined_at, :datetime
    add_column :trips, :card_id, :string
	add_column :trips, :complete_code, :string
  end
end
