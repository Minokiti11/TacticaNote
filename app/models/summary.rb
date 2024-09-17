class Summary < ApplicationRecord
    has_many :notes

    belongs_to :group, optional: true
end
