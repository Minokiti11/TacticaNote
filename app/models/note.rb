class Note < ApplicationRecord
    belongs_to :user, optional: true
    belongs_to :group, optional: true
    belongs_to :video, optional: true

    has_rich_text :content
end
