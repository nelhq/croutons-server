class CreateCampaignParticipations < ActiveRecord::Migration[7.0]
  def change
    create_table :campaign_participations do |t|
      t.references :campaign, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end

    add_index :campaign_participations, [:campaign_id, :user_id], unique: true
  end
end
