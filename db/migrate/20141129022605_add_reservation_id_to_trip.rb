class AddReservationIdToTrip < ActiveRecord::Migration
  def change
    add_column :trips, :reservation_id, :integer
  end
end
