class Contact < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :message, presence: true, length: { maximum: 1000 }

  before_validation :remove_whitespace

  private

  def remove_whitespace
    self.name = name.strip if name.present?
    self.email = email.strip if email.present?
    self.message = message.strip if message.present?
  end
end