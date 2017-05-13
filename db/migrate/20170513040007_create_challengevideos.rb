class CreateChallengevideos < ActiveRecord::Migration[5.0]
  def change
    create_table :challengevideos do |t|
      t.references :user, foreign_key: true
      t.references :video, foreign_key: true
      t.references :stream, foreign_key: true

      t.timestamps
    end
  end
end
