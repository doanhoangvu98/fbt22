class Booking < ApplicationRecord
  has_many :booking_details, dependent: :destroy
  belongs_to :user
end
