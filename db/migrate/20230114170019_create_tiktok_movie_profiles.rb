class CreateTiktokMovieProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :tiktok_movie_profiles do |t|
      t.references :tiktok_movie, null: false, foreign_key: true
      t.datetime :posted_at, null: false
      t.string :uid, null: false
      t.string :cover_image_url
      t.text :share_url, null: false
      t.text :video_description
      t.integer :duration
      t.integer :height
      t.integer :width
      t.string :title
      t.text :embed_html
      t.text :embed_link

      t.timestamps
    end
  end
end
