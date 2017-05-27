class Battle < ApplicationRecord
  validates :title, presence: true
  validates :left_video_id, presence: true
  validates :right_video_id, presence: true

  scope :recent, -> { order('created_at desc') }
  belongs_to :user

  has_many :favor_left_video_relationships
  has_many :left_followers, through: :favor_left_video_relationships, source: :user
  #has_many :right_followers, through: :favor_videos_relationships, source: :user
  has_many :favor_right_video_relationships
  has_many :right_followers, through: :favor_right_video_relationships, source: :user

  has_many :battle_comments
  has_many :comments_from_user, through: :battle_comments, source: :user
  has_many :visitor_votes
  has_many :multivotes
  belongs_to :left_video
  belongs_to :right_video
  def publish!
    self.is_hidden = false
    self.save
  end

  def hide!
    self.is_hidden = true
    self.save
  end
  
  def left_video_url
    ext_left = self.left_video.ext_video
    if ext_left
      ext_left.videourl
    else
      self.left_video.becomes(Video).video_url.to_s
    end
  end

  def right_video_url
    ext_right = self.right_video.ext_video
    if ext_right
      ext_right.videourl
    else
      self.right_video.becomes(Video).video_url.to_s
    end
  end
  def left_video_poster_url
    ext_left = self.left_video.ext_video
    if ext_left and ext_left.posturl
      ext_left.posturl
    else
      self.left_video.becomes(Video).image.thumb.to_s
    end
  end
  def right_video_poster_url
    ext_right = self.right_video.ext_video
    if ext_right and ext_right.posturl
      ext_right.posturl
    else
      self.right_video.becomes(Video).image.thumb.to_s
    end
  end

   def left_votes
      self.left_followers.count + self.visitor_votes.where(voteLeft: true).count
   end
   def right_votes
      self.right_followers.count + self.visitor_votes.where(voteLeft: false).count
   end

  scope :published, -> { where(is_hidden: false) }
end
