class Topic < ApplicationRecord
    belongs_to :t1topic
    belongs_to :user
    has_many :topic_videos
    has_many :videos , through: :topic_videos
end
