class TopicVideo < ApplicationRecord
  belongs_to :user
  belongs_to :topic
  belongs_to :video
end
