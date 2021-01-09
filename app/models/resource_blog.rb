class ResourceBlog < ApplicationRecord
  belongs_to :user
  belongs_to :tag
  has_many :resource_replys
  validates :title, presence: true, length: { minimum: 2, maximum: 40 }
  validates :content, presence: true, length: { minimum: 5, maximum: 500 }
  validates :file_path, presence: true
  validates_inclusion_of :tag_id,:in => Tag.all.collect{|x| x.id}
  # validates :response_count
  # validates :click_count
  # validates :accessment
  def feed
    ResourceReply.where("resource_blog_id = ?", self.id)
  end
end
