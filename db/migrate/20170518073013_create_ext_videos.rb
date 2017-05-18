class CreateExtVideos < ActiveRecord::Migration[5.0]
  def change
    create_table :ext_videos do |t|
      t.string :provider
      t.string :videourl
      t.string :posturl
      t.references :video, foreign_key: true

      t.timestamps
    end
  end
end
