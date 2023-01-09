module Types
  class MutationType < Types::BaseObject
    field :campaign_participation_create, mutation: Mutations::CampaignParticipationCreate
  end
end
