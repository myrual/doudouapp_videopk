class Topic < ApplicationRecord
  validates :title, presence: true
  validates :t1topic_id, presence: true
  validates :running, presence: true
  
    belongs_to :t1topic
    belongs_to :user
    has_many :topic_videos
    has_many :videos , through: :topic_videos
end
