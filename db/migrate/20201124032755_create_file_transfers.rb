class CreateFileTransfers < ActiveRecord::Migration[5.2]
  def change
    create_table :file_transfers do |t|
      t.string :file_path
      t.string :introduction

      t.timestamps
    end
  end
end
