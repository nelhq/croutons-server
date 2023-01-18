class ChangeDataTypeTitleInTiktokProfile < ActiveRecord::Migration[7.0]
  def up
    change_column :tiktok_movie_profiles, :title, :text
  end
end
