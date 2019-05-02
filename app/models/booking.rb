class Booking < ApplicationRecord
  has_many :booking_details, dependent: :destroy
  belongs_to :user
  belongs_to :tour
  enum status: {waiting: 0, cancel: 1, reject: 2, accept: 3}
  scope :order_by_create, ->{order created_at: :desc}

  validates :name, presence: true,
    length: {maximum: Settings.app.user.name_max_length}
  validates :phone, presence: true,
    length: {maximum: Settings.app.user.phone_max_length}
end
