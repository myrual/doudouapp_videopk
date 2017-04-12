class BattleComment < ApplicationRecord
  belongs_to :battle
  belongs_to :user
end
