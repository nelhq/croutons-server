FactoryBot.define do
  factory :brand do
    company { create :company }
    name { Faker::Name.name }
  end
end
