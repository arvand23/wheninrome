class AddPermalinkToTrip < ActiveRecord::Migration
  def change
    add_column :trips, :permalink, :string
  end
end
