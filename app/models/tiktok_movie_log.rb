class TiktokMovieLog < ApplicationRecord
  belongs_to :tiktok_movie
  has_one :campaign, through: :tiktok_movie
  has_one :user, through: :tiktok_movie

  def create_reward
    amount = view_count * campaign.play_unit_price
    Reward.create!(
      tikok_movie: tikok_movie,
      user: user,
      amount: amount,
    )
  end
end
