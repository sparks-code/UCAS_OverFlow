class VideoBlog < ApplicationRecord
  belongs_to :user
  belongs_to :file_transfer
  has_one :fileTransfer
  validates :title, presence: true, allow_nil: false, length: { minimum: 2, maximum: 100 }
  validates :tag, presence: true, length: { minimum: 2, maximum: 20 }
  # validates :response_count
  # validates :click_count
  # validates :accessment
end
