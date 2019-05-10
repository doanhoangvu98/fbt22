class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
    :validatable, :confirmable
  include UsersHelper
  enum role: {customer: 0, admin: 1}
  validates :phone, presence: true
  scope :sort_by_created_at_desc, ->{order created_at: :desc}
  has_many :reviews, dependent: :destroy
  has_many :banks, dependent: :destroy
  has_many :bookings, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  mount_uploader :picture, PictureUploader
end
