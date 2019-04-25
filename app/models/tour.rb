class Tour < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_many :booking_details, dependent: :destroy
  belongs_to :category
  scope :order_by_create, ->{order created_at: :desc}
end
