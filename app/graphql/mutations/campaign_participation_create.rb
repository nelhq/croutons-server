# frozen_string_literal: true

module Mutations
  class CampaignParticipationCreate < Mutations::BaseMutation
    argument :campaign_id, String, required: true
    argument :user_id, String, required: true

    field :campaign_participation, Types::Objects::CampaignParticipationType, null: false

    def resolve(**args)
      user = User.find(args[:user_id])
      Line::MessageBot.push_message(user.line_user_id, Line::MessageBot::PARTICIPATED_MESSAGE)

      campaign_participation = ::CampaignParticipation.new(args)

      if campaign_participation.save

        {
          campaign_participation: campaign_participation
        }
      else
        # raise_resource_errors(campaign)
      end
    end
  end
end
