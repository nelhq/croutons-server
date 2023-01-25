class AddHavingStatusToCampaignParticipations < ActiveRecord::Migration[7.0]
  def change
    add_column :campaign_participations, :having_status, :integer, null: false, default: 0
  end
end
