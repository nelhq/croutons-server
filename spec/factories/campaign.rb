FactoryBot.define do
  factory :campaign do
    product { create :product }
    name { Faker::Name.name }
    posted_period { Time.now }
    play_unit_price { 0.1 }
  end
end
