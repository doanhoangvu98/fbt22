class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :review
  scope :load_reply_comment, ->(reply_id){where(reply_id: reply_id)}
  scope :load_comment, ->{where(reply_id: nil)}
  validates :content, presence: true
end
