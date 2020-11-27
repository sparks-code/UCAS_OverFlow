class AddLoginDigestToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :login_digest, :string
  end
end
