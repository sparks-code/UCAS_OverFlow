class RemoveAcademyNameFromAcademyOrganizations < ActiveRecord::Migration[5.2]
  def change
    remove_column :academy_organizations, :academy_name, :string
  end
end
