class CreateBookings < ActiveRecord::Migration[5.1]
  def change
    create_table :bookings do |t|
      t.integer :quantity
      t.integer :price
      t.string :phone
      t.string :name
      t.integer :status, default: 0
      t.references :user, foreign_key: true
      t.references :tour, foreign_key: true

      t.timestamps
    end
  end
end
