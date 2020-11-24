class CreateTextReplies < ActiveRecord::Migration[5.2]
  def change
    create_table :text_replies do |t|
      t.string :reply
      t.string :references
      t.string :video_blog
      t.string :references

      t.timestamps
    end
  end
end
