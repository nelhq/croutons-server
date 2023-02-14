module Types
  class QueryType < Types::BaseObject
    field :products, resolver: Queries::Products
    field :current_user, resolver: Queries::CurrentUser
    field :campaign, resolver: Queries::Campaign
    field :campaigns, resolver: Queries::Campaigns
    field :within_posted_period_campaigns, resolver: Queries::WithinPostedPeriodCampaigns
    field :campaign_participations, resolver: Queries::CampaignParticipations
  end
end
