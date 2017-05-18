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

  scope :published, -> { where(is_hidden: false) }
end
