class VideoReply < ApplicationRecord
  belongs_to :reply
  belongs_to :video_blog
end
