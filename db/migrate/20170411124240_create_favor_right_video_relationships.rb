class CreateFavorRightVideoRelationships < ActiveRecord::Migration[5.0]
  def change
    create_table :favor_right_video_relationships do |t|
      t.integer :battle_id
      t.integer :user_id
      t.timestamps
    end
  end
end
