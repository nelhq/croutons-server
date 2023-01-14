# frozen_string_literal: true

module Types
  class Objects::UserType < Types::BaseObject
    field :id, ID, null: false
    field :tiktok_integration_status, Boolean, null: false
    field :tiktok_integration_url, String, null: true
    field :user_profile, Types::Objects::UserProfileType, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
