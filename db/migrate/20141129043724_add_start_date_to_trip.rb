class AddStartDateToTrip < ActiveRecord::Migration
  def change
    add_column :trips, :start_date, :datetime
  end
end
