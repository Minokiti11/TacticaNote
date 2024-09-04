class CreatePractices < ActiveRecord::Migration[7.0]
  def change
    create_table :practices do |t|
      t.string :name
      t.text :introduction
      t.integer :number_of_people
      t.text :issue
      t.text :key_points
      t.text :applicable_situation

      t.references :user, foreign_key: true
      t.references :group, foreign_key: true
      
      t.timestamps
    end
  end
end
