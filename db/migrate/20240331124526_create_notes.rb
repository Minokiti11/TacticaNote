class CreateNotes < ActiveRecord::Migration[7.0]
  def change
    create_table :notes do |t|
      t.string :title
      t.text :good
      t.text :bad
      t.text :next
      t.timestamps
    end
  end
end
