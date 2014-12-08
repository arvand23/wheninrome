class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trips do |t|
      t.integer :number_of_people
      t.string :email

      t.timestamps
    end
  end
end


