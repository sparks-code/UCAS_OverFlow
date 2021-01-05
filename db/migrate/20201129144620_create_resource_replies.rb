class CreateResourceReplies < ActiveRecord::Migration[5.2]
  def change
    create_table :resource_replies do |t|
      t.references :reply, foreign_key: true
      t.references :resource_blog, foreign_key: true

      t.timestamps
    end
  end
end
