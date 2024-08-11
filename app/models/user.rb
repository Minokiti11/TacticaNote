class User < ApplicationRecord
  include ActionText::Attachable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: %i[facebook twitter google_oauth2]
  has_many :group_users
  has_many :groups, through: :group_users
  attachment :profile_image, destroy: false

  has_many :messages

  has_many :sns_credential, dependent: :destroy

  class << self   # ここからクラスメソッドで、メソッドの最初につける'self.'を省略できる
    # SnsCredentialsテーブルにデータがないときの処理
    def without_sns_data(auth)
      user = User.where(email: auth.info.email).first

      if user.present?
        sns = SnsCredential.create(
          uid: auth.uid,
          provider: auth.provider,
          user_id: user.id
        )
      else   # User.newの記事があるが、newは保存までは行わないのでcreateで保存をかける
        user = User.create(
          username: auth.info.name,    # デフォルトから追加したカラムがあれば記入
          email: auth.info.email,
          # profile_image: auth.info.image,    # デフォルトから追加したカラム
          password: Devise.friendly_token(10)   # 10文字の予測不能な文字列を生成する
        )
        sns = SnsCredential.create(
          user_id: user.id,
          uid: auth.uid,
          provider: auth.provider
        )
      end
      { user:, sns: }   # ハッシュ形式で呼び出し元に返す
    end

    # SnsCredentialsテーブルにデータがあるときの処理
    def with_sns_data(auth, snscredential)
      user = User.where(id: snscredential.user_id).first
      # 変数userの中身が空文字, 空白文字, false, nilの時の処理
      if user.blank?
        user = User.create(
          username: auth.info.name,
          email: auth.info.email,
          # profile_image: auth.info.image,
          password: Devise.friendly_token(10)
        )
      end
      { user: }
    end

    # Googleアカウントの情報をそれぞれの変数に格納して上記のメソッドに振り分ける処理
    def find_oauth(auth)
      uid = auth.uid
      provider = auth.provider
      snscredential = SnsCredential.where(uid:, provider:).first
      if snscredential.present?
        user = with_sns_data(auth, snscredential)[:user]
        sns = snscredential
      else
        user = without_sns_data(auth)[:user]
        sns = without_sns_data(auth)[:sns]
      end
      { user:, sns: }
    end
  end
end
