class BookingDetail < ApplicationRecord
  belongs_to :booking
  belongs_to :tour
  belongs_to :payment
end
