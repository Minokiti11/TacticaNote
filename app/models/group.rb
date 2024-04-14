class Group < ApplicationRecord
    has_many :group_users, dependent: :destroy
    has_many :users, through: :group_users, dependent: :destroy
    has_many :messages, dependent: :destroy
    has_many :videos, dependent: :destroy

    validates :name, presence: true, uniqueness: true
    validates :introduction, presence: true
    attachment :image, destroy: false

    # 招待リンク用のトークンを生成するメソッド
    def generate_invite_token
        self.invite_token = SecureRandom.hex(10)
        self.invite_token_expires_at = 2.days.from_now # 有効期限を設定（2日間など）
    end
end
