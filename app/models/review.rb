class Review < ApplicationRecord
  enum type_review: {Place: 0, Food: 1, News: 2}
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  belongs_to :user
  belongs_to :tour
  scope :order_by_create, ->{order created_at: :desc}
  validates :content, presence: true
  validates :rating, inclusion: {in: 1..5}
  validates :type_review, presence: true
  validates :user_id, presence: true
  validates :content, presence: true,
    length: {maximum: Settings.app.review.length}

  delegate :lastname, :email, to: :user
  delegate :title, to: :tour
end
