class User < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_many :banks, dependent: :destroy
  has_many :bookings, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  before_save :downcase_email
  validates :firstname, presence: true,
    length: {maximum: Settings.app.user.first_name_max_length}
  validates :lastname, presence: true,
    length: {maximum: Settings.app.user.last_name_max_length}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
    length: {maximum: Settings.app.user.email_max_length},
    format: {with: VALID_EMAIL_REGEX},
    uniqueness: {case_sensitive: false}
  has_secure_password
  validates :password, presence: true,
    length: {minimum: Settings.app.user.pass_min_length}

  private

  # Converts email to all lower-case.
  def downcase_email
    email.downcase!
  end
end
