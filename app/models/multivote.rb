class Multivote < ApplicationRecord
    belongs_to :user
    belongs_to :battle
    belongs_to :stream
end
