class AddTokenToResponses < ActiveRecord::Migration[7.0]
  def change
    add_column :responses, :token, :string
  end
end
