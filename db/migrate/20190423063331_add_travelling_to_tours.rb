class AddTravellingToTours < ActiveRecord::Migration[5.1]
  def change
    add_reference :tours, :travelling, foreign_key: true
  end
end
