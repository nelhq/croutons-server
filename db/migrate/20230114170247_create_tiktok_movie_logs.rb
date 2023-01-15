class CreateTiktokMovieLogs < ActiveRecord::Migration[7.0]
  def change
    create_table :tiktok_movie_logs do |t|
      t.references :tiktok_movie, null: false, foreign_key: true
      t.integer :like_count, null: false
      t.integer :comment_count, null: false
      t.integer :share_count, null: false
      t.integer :view_count, null: false

      t.timestamps
    end
  end
end
