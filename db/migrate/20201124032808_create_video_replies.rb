class CreateVideoReplies < ActiveRecord::Migration[5.2]
  def change
    create_table :video_replies do |t|
      t.string :reply
      t.string :references

      t.timestamps
    end
  end
end
