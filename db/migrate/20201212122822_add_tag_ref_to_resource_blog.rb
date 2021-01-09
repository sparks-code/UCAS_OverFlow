class AddTagRefToResourceBlog < ActiveRecord::Migration[5.2]
  def change
    add_reference :resource_blogs, :tag, foreign_key: true
  end
end
