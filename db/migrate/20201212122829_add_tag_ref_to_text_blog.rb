class AddTagRefToTextBlog < ActiveRecord::Migration[5.2]
  def change
    add_reference :text_blogs, :tag, foreign_key: true
  end
end
