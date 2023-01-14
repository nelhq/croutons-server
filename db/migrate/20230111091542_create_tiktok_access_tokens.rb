class CreateTiktokAccessTokens < ActiveRecord::Migration[7.0]
  def change
    create_table :tiktok_access_tokens do |t|
      t.references :user, null: false, foreign_key: true
      t.text :access_token, null: false
      t.string :scope, null: false
      t.string :log_id, null: false
      t.string :open_id, null: false
      t.text :refresh_token, null: false
      t.integer :expires_in, null: false
      t.integer :refresh_expires_in, null: false
      t.integer :error_code, null: false

      t.timestamps
    end
  end
end
