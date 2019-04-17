class Category < ApplicationRecord
  has_many :tours, dependent: :destroy
  validates :name, presence: true,
    length: {maximum: Settings.app.category.name_max_length}
end
