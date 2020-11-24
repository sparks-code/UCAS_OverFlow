class CreateReplies < ActiveRecord::Migration[5.2]
  def change
    create_table :replies do |t|
      t.integer :send_user_id
      t.integer :receive_user_id
      t.string :content

      t.timestamps
    end
  end
end
