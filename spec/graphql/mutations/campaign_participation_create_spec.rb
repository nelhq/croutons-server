require 'rails_helper'

module Queries
  RSpec.describe Mutations::CampaignParticipationCreate, type: :request do
    let(:response_body) { JSON.parse(response.body).with_indifferent_access }
    let(:response_errors) { response_body[:errors] }
    let(:response_error_code) { response_body.dig('errors', 0, 'extensions', 'code') }
    let(:response_data) { response_body.dig :data, :campaignParticipationCreate, :campaignParticipation }

    let(:current_user) { create(:user) }
    let(:other_user) { create(:user) }
    let(:auth_headers) { current_user.create_new_auth_token }
    let(:campaign) { create(:campaign) }

    subject { post '/graphql', params: { query: query }, headers: auth_headers }

    let(:input) do
      {
        user_id: paramater_user.id.to_s,
        campaign_id: campaign.id.to_s,
        having_status: 'already_have'
      }
    end

    let(:query) do
      <<~GQL
        mutation {
          campaignParticipationCreate(
            input: #{parse_to_gql_input(input)}
          ) {
            campaignParticipation {
              id
            }
          }
        }
      GQL
    end

    describe '.resolve' do
      context 'current_user is present' do
        context 'valid query' do
          let(:paramater_user) { current_user }

          it 'returns valid response' do
            subject

            expect(response_errors).to be_blank
            expect(response_data).to be_present
          end
        end

        context 'when current user is ohter user' do
          let(:paramater_user) { other_user }
          it 'return invalid response' do
            subject

            expect(response_errors).to be_present
            expect(response_error_code).to eq('AUTHENTICATION_ERROR')
          end
        end
      end

      context 'current_user is blank' do
        let(:auth_headers) { nil }
        let(:paramater_user) { other_user }

        it 'return invalid response' do
          subject

          expect(response_errors).to be_present
          expect(response_error_code).to eq('AUTHENTICATION_ERROR')
        end
      end
    end
  end
end
