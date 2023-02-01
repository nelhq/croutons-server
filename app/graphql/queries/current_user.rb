module Queries
  class CurrentUser < BaseQuery
    type Types::Objects::UserType, null: false

    def authorized?
      context[:current_user].present?
    end

    def resolve(**args)
      context[:current_user]
    end
  end
end
