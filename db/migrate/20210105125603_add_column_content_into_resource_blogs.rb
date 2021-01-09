class AddColumnContentIntoResourceBlogs < ActiveRecord::Migration[5.2]
  def change
    add_column :resource_blogs, :content, :string
  end
end
