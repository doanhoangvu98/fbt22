class Location < ApplicationRecord
  has_many :travellings_start_id, class_name: Travelling.name,
    foreign_key: :location_start_id, dependent: :destroy
  has_many :travellings_end_id, class_name: Travelling.name,
    foreign_key: :location_end_id, dependent: :destroy
  validates :name, presence: true, uniqueness: true
  scope :sort_by_name, ->{order name: :desc}
end
