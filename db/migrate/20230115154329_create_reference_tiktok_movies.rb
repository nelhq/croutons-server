class CreateReferenceTiktokMovies < ActiveRecord::Migration[7.0]
  def change
    create_table :reference_tiktok_movies do |t|
      t.text :embed_url, null: false
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
