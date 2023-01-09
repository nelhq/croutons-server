module Types
  class MutationType < Types::BaseObject
    field :campaign_participation_create, mutation: Mutations::CampaignParticipationCreate
    field :transfer_request_create, mutation: Mutations::TransferRequestCreate
  end
end
