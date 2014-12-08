class AddTripIdToCity < ActiveRecord::Migration
  def change
    add_column :cities, :trip_id, :integer
  end
end
