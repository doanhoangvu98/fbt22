class Travelling < ApplicationRecord
  has_many :tours, dependent: :destroy
  belongs_to :location_start, class_name: Location.name,
    foreign_key: :location_start_id
  belongs_to :location_end, class_name: Location.name,
    foreign_key: :location_end_id
  scope :sort_by_created_desc, ->{order created_at: :desc}
  scope :sort_by_name_location_asc, (lambda do
    Travelling.joins(:location_start).merge(Location.order(name: :asc))
  end)
  validates :location_start, uniqueness: {scope: :location_end}
end
