module Queries
  class CampaignParticipations < BaseQuery
    type Types::Objects::CampaignParticipationType.connection_type, null: true

    def resolve(**args)
      context[:current_user].campaign_participations
    end
  end
end
