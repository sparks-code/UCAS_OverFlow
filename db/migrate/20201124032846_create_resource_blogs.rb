class CreateResourceBlogs < ActiveRecord::Migration[5.2]
  def change
    create_table :resource_blogs do |t|
      t.string :title
      t.string :tag
      t.integer :response_count, :default => 0
      t.integer :click_count, :default => 0
      t.integer :accessment
      t.references :user, foreign_key: true
      t.references :file_transfer, foreign_key: true

      t.timestamps
    end
  end
end
