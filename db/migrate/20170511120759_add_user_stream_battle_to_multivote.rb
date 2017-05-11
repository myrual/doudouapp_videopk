class AddUserStreamBattleToMultivote < ActiveRecord::Migration[5.0]
  def change
    add_reference :multivotes, :user, foreign_key: true
    add_reference :multivotes, :battle, foreign_key: true
    add_reference :multivotes, :stream, foreign_key: true
  end
end
