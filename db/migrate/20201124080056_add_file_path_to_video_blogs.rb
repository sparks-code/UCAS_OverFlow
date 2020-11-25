class AddFilePathToVideoBlogs < ActiveRecord::Migration[5.2]
  def change
    add_column :video_blogs, :file_path, :string
  end
end
