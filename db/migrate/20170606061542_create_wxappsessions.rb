class CreateWxappsessions < ActiveRecord::Migration[5.0]
  def change
    create_table :wxappsessions do |t|
      t.string :openid
      t.string :session

      t.timestamps
    end
  end
end
