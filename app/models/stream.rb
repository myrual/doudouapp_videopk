class Stream < ApplicationRecord
  belongs_to :user
  has_many :multivotes
  has_many :inside_battles, through: :multivotes, source: :battle
end
