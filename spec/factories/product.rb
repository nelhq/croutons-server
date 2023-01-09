FactoryBot.define do
  factory :product do
    brand { create :brand }
    name { Faker::Name.name }
    description { Faker::Name.name }
  end
end
