module Queries
  class Products < BaseQuery
    type [Types::Objects::ProductType], null: false

    def resolve(**args)
      Product.all
    end
  end
end
