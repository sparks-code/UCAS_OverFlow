class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :user_number
      t.string :email
      t.string :sex
      t.boolean :admin

      t.timestamps
    end
  end
end
