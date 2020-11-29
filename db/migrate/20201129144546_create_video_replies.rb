class CreateVideoReplies < ActiveRecord::Migration[5.2]
  def change
    create_table :video_replies do |t|
      t.references :reply, foreign_key: true
      t.references :video_blog, foreign_key: true

      t.timestamps
    end
  end
end
