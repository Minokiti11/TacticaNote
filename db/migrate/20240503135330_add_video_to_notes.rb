class AddVideoToNotes < ActiveRecord::Migration[7.0]
  def change
    add_reference :notes, :video, null: true, foreign_key: true
  end
end
