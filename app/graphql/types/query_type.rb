module Types
  class QueryType < Types::BaseObject
    field :products, resolver: Queries::Products
    field :campaign, resolver: Queries::Campaign
    field :campaigns, resolver: Queries::Campaigns
    field :campaign_participations, resolver: Queries::CampaignParticipations
  end
end
