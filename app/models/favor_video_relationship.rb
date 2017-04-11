class FavorVideoRelationship < ApplicationRecord
  belongs_to :battle
  #belongs_to :video
  belongs_to :user
end
