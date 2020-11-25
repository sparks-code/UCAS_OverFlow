class VideoBlog < ApplicationRecord
  belongs_to :user
  validates :title, presence: true, allow_nil: false, length: { minimum: 2, maximum: 100 }
  validates :tag, presence: true, length: { minimum: 2, maximum: 20 }
  validates :file_path, presence: true
  
  # validates :response_count
  # validates :click_count
  # validates :accessment
end
