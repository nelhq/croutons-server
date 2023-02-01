# frozen_string_literal: true

module Queries
  class BaseQuery < GraphQL::Schema::Resolver
    AUTHENTICATION_ERROR = 'AUTHENTICATION_ERROR'

    def ready?(**_args)
      true
    end

    def login_required?
      raise GraphQL::ExecutionError.new('ログインが必要です', extensions: { code: AUTHENTICATION_ERROR }) if context[:current_user].blank?
      true
    end
  end
end
