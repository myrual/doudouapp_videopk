class CreateVisitorVotes < ActiveRecord::Migration[5.0]
  def change
    create_table :visitor_votes do |t|
      t.text :visitorID
      t.references :battle, foreign_key: true
      t.boolean :voteLeft

      t.timestamps
    end
  end
end
