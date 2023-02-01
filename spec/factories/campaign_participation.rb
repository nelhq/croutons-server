FactoryBot.define do
  factory :campaign_participation do
    campaign { create :campaign }
    user { create :user }
  end
end
