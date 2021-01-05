class CreateTextBlogs < ActiveRecord::Migration[5.2]
  def change
    create_table :text_blogs do |t|
      t.string :title
      t.string :tag
      t.text :content
      t.integer :response_count
      t.integer :click_count
      t.integer :accessment
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
