class Group < ApplicationRecord
    has_many :group_users, dependent: :destroy
    has_many :users, through: :group_users, dependent: :destroy
    has_many :messages, dependent: :destroy
    has_many :videos, dependent: :destroy
    has_many :notes, dependent: :destroy
    has_many :practices, dependent: :destroy
    has_one :daily_practice, dependent: :destroy

    validates :name, presence: true
    validates :category, presence: true
    # attachment :image, destroy: false

    # 招待リンク用のトークンを生成するメソッド
    def generate_invite_token
        self.invite_token = SecureRandom.hex(10)
        self.invite_token_expires_at = 7.days.from_now # 有効期限を設定（2日間など）
    end
end
