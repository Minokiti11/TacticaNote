class CreateGroups < ActiveRecord::Migration[7.0]
  def change
    create_table :groups do |t|
      t.string :name
      t.text :introduction
      t.text :teams_behaviour
      t.text :monthly_target
      t.string :image_id
      t.integer :owner_id
      
      t.timestamps
    end
  end
end
