# frozen_string_literal: true

module Mutations
  class TransferRequestCreate < Mutations::BaseMutation
    argument :amount, Integer, required: true

    field :transfer_request, Types::Objects::TransferRequestType, null: false

    def resolve(**args)
      transfer_request = ::TransferRequest.new(args)
      transfer_request.user_id = context[:current_user].id

      if transfer_request.save
        Line::MessageBot.push_message(context[:current_user].line_user_id, Line::MessageBot::TRANSFER_REQUEST_MESSAGE)
        {
          transfer_request: transfer_request
        }
      else
        # raise_resource_errors(campaign)
      end
    end


  end
end
