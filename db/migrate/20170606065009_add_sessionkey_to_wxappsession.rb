class AddSessionkeyToWxappsession < ActiveRecord::Migration[5.0]
  def change
    add_column :wxappsessions, :wxsession_key, :string
  end
end
