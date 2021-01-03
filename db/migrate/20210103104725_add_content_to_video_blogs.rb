class AddContentToVideoBlogs < ActiveRecord::Migration[5.2]
  def change
    add_column :video_blogs, :content, :string
  end
end
