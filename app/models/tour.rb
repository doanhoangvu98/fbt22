class Tour < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_many :booking_details, dependent: :destroy
  belongs_to :category
  belongs_to :travelling
  scope :order_by_create, ->{order created_at: :desc}
  mount_uploader :image, PictureUploader
  validates :title, presence: true,
    length: {maximum: Settings.app.tour.title_max_length}
  validates :description, presence: true
  validates :price, presence: true
  validates :num_people, presence: true
  validates :image, presence: true
  validate :image_size

  private

  # Validates the size of an uploaded picture.
  def image_size
    return unless image.size > Settings.app.user.image_size_mb.megabytes
    errors.add(:image, I18n.t("users.action.maximum_size_err"))
  end
end
