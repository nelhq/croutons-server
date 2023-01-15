# frozen_string_literal: true

module Types
  class Objects::ReferenceTiktokMovieType < Types::BaseObject
    field :id, ID, null: false
    field :embed_url, String, null: false
  end
end
