class AddInviteTokenToGroups < ActiveRecord::Migration[7.0]
  def change
    add_column :groups, :invite_token, :string
    add_column :groups, :invite_token_expires_at, :datetime
  end
end
