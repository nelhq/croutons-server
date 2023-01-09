# frozen_string_literal: true

module Mutations
  class CampaignParticipationCreate < Mutations::BaseMutation
    argument :campaign_id, String, required: true

    field :campaign_participation, Types::Objects::CampaignParticipationType, null: false

    def resolve(**args)
      Line::MessageBot.push_message(context[:current_user].line_user_id, Line::MessageBot::PARTICIPATED_MESSAGE)

      campaign_participation = ::CampaignParticipation.new(args)
      campaign_participation.user_id = context[:current_user].id

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
