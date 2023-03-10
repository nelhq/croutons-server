class TiktokMovie < ApplicationRecord
  belongs_to :user
  has_one :tiktok_access_token, through: :user
  has_many :tiktok_movie_logs, dependent: :destroy
  has_one :tiktok_movie_profile, dependent: :destroy
  has_one :participation_tiktok_movie, dependent: :destroy
  has_one :campaign_participation, through: :participation_tiktok_movie
  has_one :campaign, through: :campaign_participation
  has_one :reward

  has_one :tiktok_movie_log_after_48_hours, -> (tiktok_movie) {
    where(created_at: tiktok_movie.posted_at.since(47.hours)...tiktok_movie.posted_at.since(48.hours))
  }, class_name: :TiktokMovieLog

  delegate :posted_at, to: :tiktok_movie_profile
  after_create :create_movie_profile

  validates :tiktok_uid, uniqueness: true

  scope :posted_between_minutes, -> (minutes) { joins(:tiktok_movie_profile).merge(TiktokMovieProfile.where(posted_at: (Time.zone.now.ago(minutes.minutes))..Time.zone.now)) }
  scope :posted_between_hours, -> (hours) { joins(:tiktok_movie_profile).merge(TiktokMovieProfile.where(posted_at: (Time.zone.now.ago(hours.hours))..Time.zone.now)) }

  def fetch_v2_video_query
    video_profile = tiktok_access_token.get_v2_video_query([tiktok_uid])
    video_profile.dig('data', 'videos')[0]
  end

  def create_movie_profile
    return if tiktok_movie_profile.present?

    video_profile_body = fetch_v2_video_query
    TiktokMovieProfile.create!(
      tiktok_movie: self,
      posted_at: Time.at(video_profile_body["create_time"]),
      uid: video_profile_body['id'],
      cover_image_url: video_profile_body['cover_image_url'],
      share_url: video_profile_body['share_url'],
      video_description: video_profile_body['video_description'],
      title: video_profile_body['title'],
      duration: video_profile_body['duration'],
      height: video_profile_body['height'],
      width: video_profile_body['width'],
      embed_html: video_profile_body['embed_html'],
      embed_link: video_profile_body['embed_link']
    )
  end

  def create_movie_log
    video_profile_body = fetch_v2_video_query
    TiktokMovieLog.create!(
      tiktok_movie: self,
      like_count: video_profile_body['like_count'],
      comment_count: video_profile_body['comment_count'],
      share_count: video_profile_body['share_count'],
      view_count: video_profile_body['view_count'],
    )
  end

  def source_of_reward_log
    tiktok_movie_logs.where(created_at: posted_at.since(47.hours)...posted_at.since(48.hours)).last
  end

  def view_count_after_48_hours
    tiktok_movie_log_after_48_hours&.view_count
  end

  def has_reward?
    reward.present?
  end

  def create_reward
    return if has_reward?
    return if tiktok_movie_log_after_48_hours.blank?

    tiktok_movie_log_after_48_hours.create_reward
  end
end
