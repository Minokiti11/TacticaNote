class AddContentToSummaries < ActiveRecord::Migration[7.0]
  def change
    add_column :summaries, :content, :string
    add_column :summaries, :date_for, :date
  end
end
