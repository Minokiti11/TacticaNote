class Timestamp < ApplicationRecord
    belongs_to :video, dependent: :destroy
end
