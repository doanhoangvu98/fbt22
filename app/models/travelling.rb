class Travelling < ApplicationRecord
  has_many :tours, dependent: :destroy
  belongs_to :location_start, class_name: User.name,
    foreign_key: :location_start_id
  belongs_to :location_end, class_name: User.name,
    foreign_key: :location_end_id
end
