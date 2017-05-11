class AddApproveBootleanToStreams < ActiveRecord::Migration[5.0]
  def change
    add_column :streams, :approved, :boolean
  end
end
