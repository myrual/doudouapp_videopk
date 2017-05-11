class AddIsRunningBooleanToStreams < ActiveRecord::Migration[5.0]
  def change
    add_column :streams, :running, :boolean
  end
end
