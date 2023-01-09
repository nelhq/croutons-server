class CampaignParticipation < ApplicationRecord
  belongs_to :campaign
  has_one :product, through: :campaign
  belongs_to :user

  validates :user_id,  uniqueness: { scope: [:campaign_id]  }
end
