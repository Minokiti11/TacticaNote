class Group < ApplicationRecord
    has_many :group_users, dependent: :destroy
    has_many :users, through: :group_users, dependent: :destroy
    has_many :messages, dependent: :destroy
    has_many :videos, dependent: :destroy
  
    validates :name, presence: true, uniqueness: true
    validates :introduction, presence: true
    attachment :image, destroy: false
end
