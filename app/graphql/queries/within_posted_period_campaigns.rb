module Queries
  class WithinPostedPeriodCampaigns < BaseQuery
    type Types::Objects::CampaignType.connection_type, null: true

    def resolve(**args)
      ::Campaign.within_posted_period.order(posted_period: "ASC")
    end
  end
end
