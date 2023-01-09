# frozen_string_literal: true

module Types
  class Objects::CampaignParticipationType < Types::BaseObject
    field :id, ID, null: false
    field :campaign, Types::Objects::CampaignType
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
