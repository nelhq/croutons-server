# frozen_string_literal: true

module Queries
  class BaseQuery < GraphQL::Schema::Resolver

    def ready?(**_args)
      true
    end
  end
end
