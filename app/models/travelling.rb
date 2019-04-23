class Travelling < ApplicationRecord
  has_many :tours, dependent: :destroy
  belongs_to :location_start, class_name: Location.name,
    foreign_key: :location_start_id
  belongs_to :location_end, class_name: Location.name,
    foreign_key: :location_end_id
  scope :sort_by_created_desc, ->{order created_at: :desc}
  validates :location_start, uniqueness: {scope: :location_end}
end
