class ParticipationTiktokMovie < ApplicationRecord
  belongs_to :tiktok_movie
  belongs_to :campaign_participation

  enum :status, { under_review: 0, pased_review: 1, rejected: 2}
end
