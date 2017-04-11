class Battle < ApplicationRecord
  validates :title, presence: true

  scope :recent, -> { order('created_at desc') }

  has_many :favor_left_video_relationships
  has_many :left_followers, through: :favor_left_video_relationships, source: :user
  #has_many :right_followers, through: :favor_videos_relationships, source: :user
  has_many :favor_right_video_relationships
  has_many :right_followers, through: :favor_right_video_relationships, source: :user
end
