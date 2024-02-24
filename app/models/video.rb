class Video < ApplicationRecord
    has_one_attached :video

    belongs_to :user, optional: true
    belongs_to :group, optional: true
end
