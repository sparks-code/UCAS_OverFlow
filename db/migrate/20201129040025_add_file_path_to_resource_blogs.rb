class AddFilePathToResourceBlogs < ActiveRecord::Migration[5.2]
  def change
    add_column :resource_blogs, :file_path, :string
  end
end
