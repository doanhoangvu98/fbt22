class Review < ApplicationRecord
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  belongs_to :user
  belongs_to :tour
  scope :order_by_create, ->{order created_at: :desc}
  validates :type_review, presence: true
  validates :user_id, presence: true
  validates :content, presence: true,
    length: {maximum: Settings.app.review.length}
end
