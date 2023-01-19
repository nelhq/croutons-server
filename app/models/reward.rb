class Reward < ApplicationRecord
  belongs_to :user

  class << self
    def calculate_by_tiktok_movies(tiktok_movies)
      tiktok_movies.each do |tiktok_movie|
        user = tiktok_movie.user
        campaign = tiktok_movie.campaign
        tiktok_movie_log = tiktok_movie.create_movie_log
        Reward.create!(
          user: user,
          amount: calcurate_reward(tiktok_movie_log.view_count, campaign.play_unit_price)
        )
      end
    end

    def calcurate_reward(view_count, play_unit_price)
      play_unit_price * view_count
    end

  end
end
