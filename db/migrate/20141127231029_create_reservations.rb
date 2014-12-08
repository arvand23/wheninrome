class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.timestamp :accepted_at
      t.timestamp :declined_at
      t.timestamp :start_date
      t.string :complete_code
      t.string :card_id
      t.string :permalink

      t.timestamps
    end
  end
end
