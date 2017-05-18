class LeftVideo < Video
  has_many :battles

  #has_many :favor_videos_relationships
  #has_many :followers, through: :favor_videos_relationships, source: :user
end