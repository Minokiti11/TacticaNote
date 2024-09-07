class CreateDailyPracticeItems < ActiveRecord::Migration[7.0]
  def change
    create_table :daily_practice_items do |t|
      t.references :practice, null: false, foreign_key: true
      t.references :daily_practice, null: false, foreign_key: true
      t.integer :training_time

      t.timestamps
    end
  end
end
