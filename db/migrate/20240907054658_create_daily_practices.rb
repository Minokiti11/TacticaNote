class CreateDailyPractices < ActiveRecord::Migration[7.0]
  def change
    create_table :daily_practices do |t|
      t.references :group, null: false, foreign_key: true
      t.integer :duration
      
      t.timestamps
    end
  end
end
