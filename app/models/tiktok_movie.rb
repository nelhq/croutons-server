class TiktokMovie < ApplicationRecord
  belongs_to :user
  has_one :tiktok_access_token, through: :user
  has_many :tiktok_movie_logs, dependent: :destroy
  has_one :tiktok_movie_profile, dependent: :destroy
  has_one :participation_tiktok_movie, dependent: :destroy
  has_one :campaign_participation, through: :participation_tiktok_movie
  has_one :campaign, through: :campaign_participation

  after_create :create_movie_profile

  validates :tiktok_uid, uniqueness: true

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

end
