class AddRoleRefToUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :role, :integer, if_exists: true
  add_reference :users, :role, foreign_key: { to_table: :user_roles }
  end
end