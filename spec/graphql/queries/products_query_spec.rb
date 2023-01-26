require 'rails_helper'

module Queries
  RSpec.describe Products, type: :request do
    let(:response_body) { JSON.parse(response.body).with_indifferent_access }
    let(:response_errors) { response_body[:errors] }
    let(:response_error_code) { response_body.dig('errors', 0, 'extensions', 'code') }
    let(:response_data) { response_body.dig :data, :products }

    subject { post '/graphql', params: { query: query } }

    describe '.resolve' do
      let(:query) do
        <<~GQL
          query {
            products {
              id
              name
              description
            }
          }
        GQL
      end

      context 'when valid query' do
        let(:insert_count) { 5 }
        before do
          create_list(:product, insert_count)
        end

        it 'returns valid response' do
          subject

          expect(response_errors).to be_blank
        end

        it 'returns allowed products' do
          subject

          expect(response_data.count).to eq(insert_count)
        end
      end
    end
  end
end
