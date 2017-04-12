class CreateBattleComments < ActiveRecord::Migration[5.0]
  def change
    create_table :battle_comments do |t|
      t.integer :battle_id
      t.integer :user_id
      t.text    :comment
      t.timestamps
    end
  end
end
