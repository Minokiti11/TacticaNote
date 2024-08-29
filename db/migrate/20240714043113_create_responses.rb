class CreateResponses < ActiveRecord::Migration[7.0]
  def change
    create_table :responses do |t|
      t.string :section_type, null: true # "good" or "bad" or "next" or "discuss"
      t.text :input # Input entered by the user
      t.text :response # response from GPT4 API
      
      t.references :user, foreign_key: true
      t.references :group, foreign_key: true
      t.references :video, null: true, foreign_key: true
      t.timestamps
    end
  end
end
