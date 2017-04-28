class AddUserRefToBattles < ActiveRecord::Migration[5.0]
  def change
    add_reference :battles, :user, foreign_key: true
  end
end
