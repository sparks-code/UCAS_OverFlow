class ResourceReply < ApplicationRecord
  belongs_to :reply
  belongs_to :resource_blog
end
