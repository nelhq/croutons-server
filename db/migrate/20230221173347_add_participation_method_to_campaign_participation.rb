class AddParticipationMethodToCampaignParticipation < ActiveRecord::Migration[7.0]
  def change
    add_column :campaign_participations, :participation_method, :string
  end
end
