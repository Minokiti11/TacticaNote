class AddNoteForToNotes < ActiveRecord::Migration[7.0]
  def change
    add_column :notes, :note_for, :string
  end
end
