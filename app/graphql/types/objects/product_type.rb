# frozen_string_literal: true

module Types
  class Objects::ProductType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :description, String, null: true
    field :parsed_description, String, null: true
    field :image_urls, [String], null: true
    field :primary_image_url, String, null: true
    field :price, Integer, null: true
    field :reference_tiktok_movies, [::Types::Objects::ReferenceTiktokMovieType], null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
