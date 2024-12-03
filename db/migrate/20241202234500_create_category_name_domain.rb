class CreateCategoryNameDomain < ActiveRecord::Migration[7.0]
  def up
    execute <<-SQL
      CREATE DOMAIN category_name AS TEXT
      CHECK (VALUE IN ('basic_sanitation', 'infraestructure', 'paving', 'public_safety', 'street_lighting'));
    SQL

    change_column :categories, :name, :category_name
  end

  def down
    change_column :categories, :name, :string

    execute <<-SQL
      DROP DOMAIN category_name;
    SQL
  end
end