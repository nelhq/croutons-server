class CreateUserProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :user_profiles, options: "DEFAULT CHARSET=utf8mb4" do |t|
      t.references :user, null: false, foreign_key: true
      t.string :tiktok_user_name
      t.text :tiktok_user_image_url
      t.string :tiktok_open_id
      t.string :tiktok_union_id
      t.text :tiktok_profile_deep_link

      t.timestamps
    end
  end
end
