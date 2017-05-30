class RemoveT1topicFromTopics < ActiveRecord::Migration[5.0]
  def change
    remove_column :topics, :t1topic, :reference
  end
end
