class CreateTours < ActiveRecord::Migration[5.1]
  def change
    create_table :tours do |t|
      t.string :title
      t.text :description
      t.integer :price
      t.string :image
      t.integer :num_people
      t.datetime :tour_start
      t.datetime :tour_finish
      t.integer :status, default: 0
      t.timestamps
    end
  end
end
