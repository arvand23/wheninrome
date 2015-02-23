class AddChargeGuidToTrip < ActiveRecord::Migration
  def change
    add_column :trips, :charge_guid, :string
  end
end
