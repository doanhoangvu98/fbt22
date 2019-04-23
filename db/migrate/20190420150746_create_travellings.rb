class CreateTravellings < ActiveRecord::Migration[5.1]
  def change
    create_table :travellings do |t|
      t.references :location_start, foreign_key: true
      t.references :location_end, foreign_key: true

      t.timestamps
    end
  end
end
