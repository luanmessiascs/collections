class Album < ApplicationRecord
    belongs_to(:collection)
    has_many(:items)

    validates :title, presence: true
end
