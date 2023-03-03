module Queries
  class Campaigns < BaseQuery
    type Types::Objects::CampaignType.connection_type, null: true

    def resolve(**args)
      ::Campaign.all.order(posted_period: "DESC")
    end
  end
end
