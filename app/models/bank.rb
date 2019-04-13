class Bank < ApplicationRecord
  has_many :payments, dependent: :destroy
  belongs_to :user
end
