class CreateUserRoles < ActiveRecord::Migration[7.0]
  def change
    create_table :user_roles do |t|
      t.string :name, null: false, unique: true
      t.timestamps
    end
    add_index :user_roles, :name, unique: true
  end
end
