class Video < ApplicationRecord
  mount_uploader :image, ImageUploader
  mount_uploader :video, VideoUploader
  validates :title, presence: true

  belongs_to :user
  has_many :video_comments
  has_many :comments_from_user, through: :video_comments, source: :user
  has_many :challengevideos
  has_one :ext_video

  #has_many :favor_videos_relationships
  #has_many :followers, through: :favor_videos_relationships, source: :user
  def poster_url
    ext_right = self.becomes(Video).ext_video
    if ext_right and ext_right.posturl
      ext_right.posturl
    else
      if self.becomes(Video).image.thumb.to_s == ""
        return nil
      end
      self.becomes(Video).image.thumb.to_s
    end
  end
  def unique_url
    ext_v = self.becomes(Video).ext_video
    if ext_v
      ext_v.videourl
    else
      self.becomes(Video).video_url.to_s
    end
  end
end
