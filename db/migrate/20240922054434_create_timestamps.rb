class CreateTimestamps < ActiveRecord::Migration[7.0]
  def change
    create_table :timestamps do |t|
      t.references :video, foreign_key: true
      t.integer :time_s
      t.string :description
      t.timestamps
    end
  end
end
