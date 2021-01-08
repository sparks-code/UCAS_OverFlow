class TextBlog < ApplicationRecord
  belongs_to :user
  belongs_to :tag
  has_many :text_replys
  validates :title, presence: true, length: { minimum: 2, maximum: 40 }
  validates :content, presence: true, length: { minimum: 5, maximum: 500 }
  validates_inclusion_of :tag_id,:in => Tag.all.collect{|x| x.id}
  def feed
    TextReply.where("text_blog_id = ?", self.id)
  end
end
