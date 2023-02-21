class Campaign < ApplicationRecord
  belongs_to :product
  has_one :brand, through: :product
  has_many :campaign_participations, dependent: :destroy
  has_many :users, through: :campaign_participations

  scope :within_posted_period, -> { where("posted_period >= ?", Time.zone.now) }

  def participated_user_id
    user_ids
  end

  def participation_count
    campaign_participations.count + 3
  end

  def parsed_posted_period
    posted_period.strftime("%Y/%m/%d")
  end

  def parsed_posted_period_contains_hours
    posted_period.strftime("%Y/%m/%d %H:%M")
  end

end
