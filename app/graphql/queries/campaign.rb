module Queries
  class Campaign < BaseQuery
    type Types::Objects::CampaignType, null: true

    argument :id, ID, required: true

    def resolve(**args)
      ::Campaign.find(args[:id])
    end
  end
end
