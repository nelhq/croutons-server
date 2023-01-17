# frozen_string_literal: true

module Types
  class Objects::CampaignType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :product, Types::Objects::ProductType, null: false
    field :brand, Types::Objects::BrandType, null: false
    field :posted_period, GraphQL::Types::ISO8601DateTime, null: false
    field :parsed_posted_period, String, null: false
    field :is_participated, Boolean, null: false
    field :participation_count, Integer, null: false
    field :play_unit_price, Float, null: false

    def is_participated
      if context[:current_user].present?
        object.user_ids.include?(context[:current_user].id)
      else
        false
      end
    end
  end
end
