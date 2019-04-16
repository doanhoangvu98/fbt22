class Payment < ApplicationRecord
  has_many :booking_details
  belongs_to :bank
end
