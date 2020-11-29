class RemoveFileTransferIdFromResourceBlogs < ActiveRecord::Migration[5.2]
  def change
    remove_column :resource_blogs, :file_transfer_id, :integer
  end
end
