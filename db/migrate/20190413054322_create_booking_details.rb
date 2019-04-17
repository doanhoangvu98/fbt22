class CreateBookingDetails < ActiveRecord::Migration[5.1]
  def change
    create_table :booking_details do |t|
      t.integer :quantity
      t.integer :price
      t.references :booking, foreign_key: true
      t.references :tour, foreign_key: true
      t.references :payment, foreign_key: true

      t.timestamps
    end
  end
end
