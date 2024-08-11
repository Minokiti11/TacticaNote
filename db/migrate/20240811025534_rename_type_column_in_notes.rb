class RenameTypeColumnInNotes < ActiveRecord::Migration[7.0]
  def change
    rename_column :notes, :type, :note_type
  end
end
