class CampaignParticipation < ApplicationRecord
  belongs_to :campaign
  has_one :product, through: :campaign
  belongs_to :user
  has_many :participation_tiktok_movies, dependent: :destroy
  has_many :tiktok_movies, through: :participation_tiktok_movies

  validates :user_id,  uniqueness: { scope: [:campaign_id]  }

  def posted_movie?
    tiktok_movies.present?
  end
end
