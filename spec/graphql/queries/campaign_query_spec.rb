require 'rails_helper'

module Queries
  RSpec.describe Campaign, type: :request do
    let(:response_body) { JSON.parse(response.body).with_indifferent_access }
    let(:response_errors) { response_body[:errors] }
    let(:response_error_code) { response_body.dig('errors', 0, 'extensions', 'code') }
    let(:response_data) { response_body.dig :data, :products }

    subject { post '/graphql', params: { query: query } }

    describe '.resolve' do
      let(:query) do
        <<~GQL
          query {
            campaign(id: "#{campaign.id}") {
              id
              name
            }
          }
        GQL
      end

      context 'when valid query' do
        let(:campaign) { create(:campaign) }

        it 'returns valid response' do
          subject

          expect(response_errors).to be_blank
        end
      end
    end
  end
end
