class AddTikotkMovieToReward < ActiveRecord::Migration[7.0]
  def change
    add_reference :rewards, :tiktok_movie, index: { unique: true }, foreign_key: true, null: false
  end
end
