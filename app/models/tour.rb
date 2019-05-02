class Tour < ApplicationRecord
  enum status: {open: 0, close: 1}
  has_many :reviews, dependent: :destroy
  has_many :bookings, dependent: :destroy
  belongs_to :category
  belongs_to :travelling
  scope :order_by_create, ->{order created_at: :desc}
  scope :load_tours_by_filter, (lambda do |title|
    (where "title LIKE ?", "%#{title}%")
  end)
  scope :search, ->(term){load_tours_by_filter term}
  delegate :location_start, :location_end, to: :travelling

  mount_uploader :image, PictureUploader
  validates :title, presence: true,
    length: {maximum: Settings.app.tour.title_max_length}
  validates :description, presence: true
  validates :price, presence: true
  validates :num_people, presence: true
  validate :image_size

  def self.search_by search_term
    where "title LIKE ? OR price LIKE ?", "%#{search_term}%", "%#{search_term}%"
  end

  def has_review?
    reviews.present?
  end

  def average_review
    reviews.sum("rating") / reviews.count
  end

  def self.search_by search_term
    where "title LIKE ? OR price LIKE ?", "%#{search_term}%", "%#{search_term}%"
  end

  def average_review
    reviews.sum("rating") / reviews.count
  end

  private

  # Validates the size of an uploaded picture.
  def image_size
    return unless image.size > Settings.app.user.image_size_mb.megabytes
    errors.add(:image, I18n.t("users.action.maximum_size_err"))
  end
end
