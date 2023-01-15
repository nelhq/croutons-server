class RenameTiktokMovie < ActiveRecord::Migration[7.0]
  def change
    rename_column :tiktok_movies, :url, :tiktok_uid
  end
end
