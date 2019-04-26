class Category < ApplicationRecord
  has_many :tours, dependent: :destroy
  validates :name, presence: true,
    length: {maximum: Settings.app.category.name_max_length}
  scope :sort_by_name_at_asc, ->{order name: :asc}
end
