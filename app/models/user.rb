class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  has_many :group_users
  has_many :groups, through: :group_users
  attachment :profile_image, destroy: false

  has_many :messages

  devise :omniauthable, omniauth_providers: %i[google_oauth2]
  
  validates :uid, uniqueness: { scope: :provider }

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.name = auth.info.name
      user.password = Devise.friendly_token[0,20]
      user.avatar = auth.info.image
      user.skip_confirmation!
    end
  end
end
