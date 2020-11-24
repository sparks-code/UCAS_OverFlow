class CreateAcademyOrganizations < ActiveRecord::Migration[5.2]
  def change
    create_table :academy_organizations do |t|
      t.string :code_number
      t.string :academy_name
      t.string :organization_name

      t.timestamps
    end
  end
end
