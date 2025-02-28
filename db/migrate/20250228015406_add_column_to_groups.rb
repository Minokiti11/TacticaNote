class AddColumnToGroups < ActiveRecord::Migration[8.0]
  def change
    add_column :groups, :category, :string
  end
end
