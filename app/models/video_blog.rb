class VideoBlog < ApplicationRecord
  belongs_to :user
  belongs_to :tag
  has_many :video_replys
  validates :title, presence: true, allow_nil: false, length: { minimum: 2, maximum: 40 }
  #validates :tag, presence: true, length: { minimum: 2, maximum: 20 }
  validates :content, presence: true, length: { minimum: 2, maximum: 500 }
  validates :file_path, presence: true
  validates_inclusion_of :tag_id,:in => Tag.all.collect{|x| x.id}
  # validates :response_count
  # validates :click_count
  # validates :accessment
  def feed
    VideoReply.where("video_blog_id = ?", self.id)
  end
end
