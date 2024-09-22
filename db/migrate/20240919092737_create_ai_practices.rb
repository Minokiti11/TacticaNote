class CreateAiPractices < ActiveRecord::Migration[7.0]
  def change
    create_table :ai_practices do |t|
      t.references :group, foreign_key: true
      t.text :content
      t.date :date_for
      t.timestamps
    end
  end
end
