# frozen_string_literal: true

module Types
  class Objects::UserProfileType < Types::BaseObject
    field :id, ID, null: false
    field :tiktok_user_name, String, null: true
    field :tiktok_user_image_url, String, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
