class VideoBlog < ApplicationRecord
  belongs_to :user
  belongs_to :file_transfer
end
