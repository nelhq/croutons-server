class Campaign < ApplicationRecord
  belongs_to :product
  has_one :brand, through: :product
  has_many :campaign_participations
  has_many :users, through: :campaign_participations

  def participated_user_id
    user_ids
  end

  def participation_count
    campaign_participations.count + 3
  end

  def parsed_posted_period
    posted_period.strftime("%Y/%m/%d")
  end
end
