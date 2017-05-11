class AddOrderToMultivote < ActiveRecord::Migration[5.0]
  def change
    add_column :multivotes, :order, :integer
  end
end
