class Challengevideo < ApplicationRecord
  belongs_to :user
  belongs_to :video
  belongs_to :stream
end
