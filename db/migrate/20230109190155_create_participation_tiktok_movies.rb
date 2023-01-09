class CreateParticipationTiktokMovies < ActiveRecord::Migration[7.0]
  def change
    create_table :participation_tiktok_movies do |t|
      t.references :tiktok_movie, null: false, foreign_key: true
      t.references :campaign_participation, null: false, foreign_key: true
      t.integer :status, null: false, default: 0

      t.timestamps
    end

    add_index :participation_tiktok_movies, [:tiktok_movie_id, :campaign_participation_id], name: "ptm_tm_cp_unique_index"
  end
end
