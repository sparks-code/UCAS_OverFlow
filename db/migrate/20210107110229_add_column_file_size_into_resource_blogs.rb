class AddColumnFileSizeIntoResourceBlogs < ActiveRecord::Migration[5.2]
  def change
    add_column :resource_blogs, :file_size, :string
  end
end
