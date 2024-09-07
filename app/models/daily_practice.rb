class DailyPractice < ApplicationRecord
    belongs_to :group
    belongs_to :practice, optional: true

    has_many :daily_practice_items
    has_many :practices, through: :daily_practice_items
end
