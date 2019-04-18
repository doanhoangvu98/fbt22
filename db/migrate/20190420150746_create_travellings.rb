class CreateTravellings < ActiveRecord::Migration[5.1]
  def change
    create_table :travellings do |t|
      t.references :location_start
      t.references :location_end

      t.timestamps
    end
  end
end
