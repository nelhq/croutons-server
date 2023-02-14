require 'rails_helper'

module Queries
  RSpec.describe Queries::CampaignParticipations, type: :request do
    let(:response_body) { JSON.parse(response.body).with_indifferent_access }
    let(:response_errors) { response_body[:errors] }
    let(:response_error_code) { response_body.dig('errors', 0, 'extensions', 'code') }
    let(:response_edges) { response_body.dig :data, :withinPostedPeriodCampaigns, :edges }

    let(:current_user) { create(:user) }
    let(:auth_headers) { current_user.create_new_auth_token }

    subject { post '/graphql', params: { query: query }, headers: auth_headers }

    let(:insert_count) { 5 }
    before do
      create_list(:campaign, insert_count, posted_period: Time.zone.now + 1.day)
    end

    describe '.resolve' do
      let(:query) do
        <<~GQL
          query {
            withinPostedPeriodCampaigns {
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

      context 'valid query' do
        it 'returns valid response' do
          subject

          expect(response_errors).to be_blank
          expect(response_edges.count).to eq(insert_count)
        end
      end

    end
  end
end
