# frozen_string_literal: true

module Queries
  class BaseQuery < GraphQL::Schema::Resolver
    # include RaiseGqlResourceErrors

    def ready?(**_args)
      true
    end
  end
end
