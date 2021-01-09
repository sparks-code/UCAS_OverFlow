class RemoveTagFromVideoBlogs < ActiveRecord::Migration[5.2]
  def change
    remove_column :video_blogs, :tag, :string
  end
end
