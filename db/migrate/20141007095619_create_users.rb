class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :provider
      t.string :uid
      t.string :user_id
      t.string :token
      t.string :refresh_token
      t.decimal :token_expires_at
      t.timestamps
    end
  end
end
