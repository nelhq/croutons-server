require 'rails_helper'

module Queries
  RSpec.describe Queries::CampaignParticipations, type: :request do
    let(:response_body) { JSON.parse(response.body).with_indifferent_access }
    let(:response_errors) { response_body[:errors] }
    let(:response_error_code) { response_body.dig('errors', 0, 'extensions', 'code') }
    let(:response_edges) { response_body.dig :data, :campaignParticipations, :edges }

    let(:current_user) { create(:user) }
    let(:auth_headers) { current_user.create_new_auth_token }

    subject { post '/graphql', params: { query: query }, headers: auth_headers }

    let(:current_user_insert_count) { 5 }
    before do
      create_list(:campaign_participation, current_user_insert_count, user: current_user)
    end

    let(:other_insert_count) { 3 }
    before do
      create_list(:campaign_participation, other_insert_count)
    end

    describe '.resolve' do
      let(:query) do
        <<~GQL
          query {
            campaignParticipations {
              pageInfo {
                hasPreviousPage
                hasNextPage
                endCursor
                startCursor
              }
              edges {
                cursor
                node {
                  id
                }
              }
            }
          }
        GQL
      end

      context 'current_user is present' do
        it 'returns valid response' do
          subject

          expect(response_errors).to be_blank
          expect(response_edges.count).to eq(current_user_insert_count)
        end
      end

      context 'current_user is blank' do
        let(:auth_headers) { nil }

        it 'return invalid response' do
          subject

          expect(response_errors).to be_present
          expect(response_error_code).to eq('AUTHENTICATION_ERROR')
        end
      end
    end
  end
end
