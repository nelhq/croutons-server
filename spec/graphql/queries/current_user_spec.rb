require 'rails_helper'

module Queries
  RSpec.describe Campaign, type: :request do
    let(:response_body) { JSON.parse(response.body).with_indifferent_access }
    let(:response_errors) { response_body[:errors] }
    let(:response_error_code) { response_body.dig('errors', 0, 'extensions', 'code') }
    let(:response_data) { response_body.dig :data, :currentUser }

    let(:current_user) { create(:user) }
    let(:auth_headers) { current_user.create_new_auth_token }

    subject { post '/graphql', params: { query: query }, headers: auth_headers }

    describe '.resolve' do
      let(:query) do
        <<~GQL
          query {
            currentUser {
              id
              tiktokIntegrationStatus
            }
          }
        GQL
      end

      context 'current_user is present' do
        it 'returns valid response' do
          subject

          expect(response_errors).to be_blank
          expect(response_data['id'].to_i).to eq(current_user.id)
        end
      end

      context 'current_user is blank' do
        let(:auth_headers) { nil }

        it 'return invalid response' do
          subject

          expect(response_errors).to be_present
          expect(response_error_code).to eq(Queries::BaseQuery::AUTHENTICATION_ERROR)
        end
      end
    end
  end
end
