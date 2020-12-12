class RemoveTagFromResourceBlogs < ActiveRecord::Migration[5.2]
  def change
    remove_column :resource_blogs, :tag, :string
  end
end
