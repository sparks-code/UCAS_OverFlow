class CreateTextReplies < ActiveRecord::Migration[5.2]
  def change
    create_table :text_replies do |t|
      t.references :reply, foreign_key: true
      t.references :text_blog, foreign_key: true

      t.timestamps
    end
  end
end
