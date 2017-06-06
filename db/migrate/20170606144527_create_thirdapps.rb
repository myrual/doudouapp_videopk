class CreateThirdapps < ActiveRecord::Migration[5.0]
  def change
    create_table :thirdapps do |t|
      t.string :appid
      t.string :secret

      t.timestamps
    end
  end
end
