class AddIsHiddenToBattle < ActiveRecord::Migration[5.0]
  def change
    add_column :battles, :is_hidden, :boolean, default: true
  end
end
