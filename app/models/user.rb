class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def admin?
    is_admin
  end

  has_many :videos
  has_many :video_comments
  has_many :comments_for_videos, through: :video_comments, source: :video

  has_many :favor_videos_relationships
  has_many :favor_videos, through: :favor_videos_relationships, source: :video

  def has_follow?(video)
    favor_videos.include?(chef)
  end

  def follow!(video)
    favor_videos << video
  end

  def unfollow!(video)
    favor_videos.delete(video)
  end
end
