class FileTransfer < ApplicationRecord
    has_one :videoBlog
    validates :file_path, presence: true, length: { minimum: 1, maximum: 40 }
end
