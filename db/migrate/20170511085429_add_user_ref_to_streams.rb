class AddUserRefToStreams < ActiveRecord::Migration[5.0]
  def change
    add_reference :streams, :user, foreign_key: true
  end
end
