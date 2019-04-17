class User < ApplicationRecord
  attr_accessor :remember_token
  enum role: {customer: 0, admin: 1}
  scope :sort_by_created_at_desc, ->{order created_at: :desc}
  has_many :reviews, dependent: :destroy
  has_many :banks, dependent: :destroy
  has_many :bookings, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  mount_uploader :picture, PictureUploader
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
    length: {minimum: Settings.app.user.pass_min_length}, allow_nil: true
  validate :picture_size

  class << self
    # Return the hash digest of the given string.
    def digest string
      cost = if ActiveModel::SecurePassword.min_cost
               BCrypt::Engine::MIN_COST
             else
               BCrypt::Engine.cost
             end
      BCrypt::Password.create string, cost: cost
    end

    # Returns a random token.
    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  # Remembers a user in the database for use in persistent sessions.
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Returns true if the given token matches the digest.
  def authenticated? remember_token
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # Forgets a user.
  def forget
    update_attribute(:remember_digest, nil)
  end

  private

  # Validates the size of an uploaded picture.
  def picture_size
    return unless picture.size > Settings.app.user.image_size_mb.megabytes
    errors.add(:picture, t("users.action.maximum_size_err"))
  end

  # Converts email to all lower-case.
  def downcase_email
    email.downcase!
  end
end
