class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :group_users
  has_many :groups, through: :group_users
  attachment :profile_image, destroy: false
  # validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  # validates :introduction, length: { maximum: 50 }
end
