FactoryBot.define do
  factory :reward do
    user { create :user }
    tiktok_movie { create :tiktok_movie }
    amount { 100 }
  end
end
