class Timestamp < ApplicationRecord
    belongs_to :video, optional: true
end
