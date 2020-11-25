class RemoveFileTransferIdFromVideoBlogs < ActiveRecord::Migration[5.2]
  def change
    remove_column :video_blogs, :file_transfer_id, :integer
  end
end
