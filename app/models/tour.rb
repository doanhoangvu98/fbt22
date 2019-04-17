class Tour < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_many :booking_details, dependent: :destroy
end
