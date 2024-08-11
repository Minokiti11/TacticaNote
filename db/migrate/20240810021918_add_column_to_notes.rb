class AddColumnToNotes < ActiveRecord::Migration[7.0]
  def change
    add_column :notes, :type, :string
    add_column :notes, :discuss, :text
  end
end
