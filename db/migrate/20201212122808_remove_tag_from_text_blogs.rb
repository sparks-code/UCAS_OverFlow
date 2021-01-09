class RemoveTagFromTextBlogs < ActiveRecord::Migration[5.2]
  def change
    remove_column :text_blogs, :tag, :string
  end
end
