class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|
      t.string :code_number
      t.string :project_name

      t.timestamps
    end
  end
end
