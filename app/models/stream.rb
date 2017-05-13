class Stream < ApplicationRecord
  belongs_to :user
  has_many :multivotes
  has_many :inside_battles, through: :multivotes, source: :battle
  has_many :challengevideos
  has_many :inside_videos, through: :challengevideos, source: :video
end
