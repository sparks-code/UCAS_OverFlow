class TextReply < ApplicationRecord
  belongs_to :reply
  belongs_to :text_blog
end
