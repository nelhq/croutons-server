FactoryBot.define do
  factory :reward do
    user { create :user }
    amount { 100 }
  end
end
