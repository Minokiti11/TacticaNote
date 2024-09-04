class AddUserToPractices < ActiveRecord::Migration[7.0]
  def change
    add_reference :practices, :user, foreign_key: true
  end
end
