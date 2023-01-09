# frozen_string_literal: true

module Types
  class Objects::TransferRequestType < Types::BaseObject
    field :id, ID, null: false
    field :amount, Integer, null: false
  end
end
