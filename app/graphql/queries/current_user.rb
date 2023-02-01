module Queries
  class CurrentUser < BaseQuery
    type Types::Objects::UserType, null: false

    def authorized?
      login_required?
    end

    def resolve(**args)
      context[:current_user]
    end
  end
end
