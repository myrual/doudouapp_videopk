class CreateUseravatars < ActiveRecord::Migration[5.0]
  def change
    create_table :useravatars do |t|
      t.string :url
      t.string :provider
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
