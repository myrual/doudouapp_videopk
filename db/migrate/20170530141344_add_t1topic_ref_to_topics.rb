class AddT1topicRefToTopics < ActiveRecord::Migration[5.0]
  def change
    add_reference :topics, :t1topic, foreign_key: true
  end
end
