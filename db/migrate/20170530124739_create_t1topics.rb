class CreateT1topics < ActiveRecord::Migration[5.0]
  def change
    create_table :t1topics do |t|
      t.string :title
      t.boolean :running
      t.integer :order

      t.timestamps
    end
  end
end
