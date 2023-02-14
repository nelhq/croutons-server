FactoryBot.define do
  factory :tiktok_movie do
    user { create :user }
    tiktok_uid { SecureRandom.uuid }

    after(:build) do |user|
      class << user
       def create_movie_profile
         true
       end
      end
    end

  end
end
