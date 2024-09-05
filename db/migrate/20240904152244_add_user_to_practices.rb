class AddUserToPractices < ActiveRecord::Migration[7.0]
  def change
    # user_id カラムを practices テーブルに追加
    add_column :practices, :user_id, :integer

    # 外部キーを設定 (on_delete: :cascade)
    add_foreign_key :practices, :users, on_delete: :cascade
  end
end
