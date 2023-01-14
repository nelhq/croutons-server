module Queries
  class CurrentUser < BaseQuery
    type Types::Objects::UserType, null: false

    def resolve(**args)
      context[:current_user]
    end
  end
end
