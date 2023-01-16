class CreateTiktokMovies < ActiveRecord::Migration[7.0]
  def change
    create_table :tiktok_movies, options: "DEFAULT CHARSET=utf8mb4" do |t|
      t.references :user, null: false, foreign_key: true
      t.text :url, null: false

      t.timestamps
    end
  end
end
