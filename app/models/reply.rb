class Reply < ApplicationRecord
    validates :content, presence: true, length: { minimum: 2, maximum: 50 } 
end
