class TiktokAccessToken < ApplicationRecord
  belongs_to :user

  DEFAULT_PROFILE_FIELDS = "open_id,union_id,avatar_url,display_name,profile_deep_link,is_verified,follower_count,following_count,likes_count"
  CLINET_KEY = ENV['TIKTOK_KEY']
  CLINET_SECRET = ENV['TIKTOK_SECRET']
  DEFAULT_SCOPE = "user.info.basic,video.list"
  DEFAULT_VIDEO_FIELDS = "id,create_time,cover_image_url,share_url,video_description,duration,height,width,title,embed_html,embed_link,like_count,comment_count,share_count,view_count"
  RESPONSE_TYPE = "code"
  REDIRECT_PATH = "http://localhost:4001"

  class << self
    def authenticate_url
      response = Faraday.get('https://www.tiktok.com/auth/authorize/') do |request|
        request.params = {
          client_key: CLINET_KEY,
          scope: DEFAULT_SCOPE,
          response_type: RESPONSE_TYPE,
          redirect_uri: REDIRECT_PATH,
        }
      end
      uri
    end

    def get_access_token(code)
      response = Faraday.get('https://open-api.tiktok.com/oauth/access_token/') do |request|
        request.params = {
          client_key: CLINET_KEY,
          grant_type: 'authorization_code',
          client_secret: CLINET_SECRET,
          code: code
        }
      end
      body = JSON.parse(response.body)
    end

    def create_by_token_response!(response_token_body, user)
      self.create!(
        user: user,
        access_token: response_token_body.dig('data', 'access_token'),
        log_id: response_token_body.dig('data', 'log_id'),
        open_id: response_token_body.dig('data', 'open_id'),
        refresh_token: response_token_body.dig('data', 'refresh_token'),
        scope: response_token_body.dig('data', 'scope'),
        expires_in: response_token_body.dig('data', 'expires_in'),
        refresh_expires_in: response_token_body.dig('data', 'refresh_expires_in'),
        error_code: response_token_body.dig('data', 'error_code')
      )
    end
  end

  def get_v2_user_info
    response = Faraday.get('https://open.tiktokapis.com/v2/user/info/') do |request|
      request.headers['Authorization'] = "Bearer #{access_token}"
      request.params = {
        fields: DEFAULT_PROFILE_FIELDS,
      }
    end
    body = JSON.parse(response.body)
  end

  def get_v2_video_query(video_ids)
    response = Faraday.post('https://open.tiktokapis.com/v2/video/query/') do |request|
      request.headers["Authorization"] = "Bearer #{access_token}"
      request.headers["Content-Type"] = "application/json"
      request.params = {
        fields: DEFAULT_VIDEO_FIELDS
      }
      request.body = { "filters": { "video_ids": video_ids }}.to_json
    end
    body = JSON.parse(response.body)
  end

  def refresh_access_token
    response = Faraday.get('https://open-api.tiktok.com/oauth/refresh_token/') do |request|
      request.params = {
        client_key: CLINET_KEY,
        grant_type: 'refresh_token',
        refresh_token: refresh_token
      }
    end
    response_token_body = JSON.parse(response.body)

    self.update!(
      access_token: response_token_body.dig('data', 'access_token'),
      log_id: response_token_body.dig('data', 'log_id'),
      open_id: response_token_body.dig('data', 'open_id'),
      refresh_token: response_token_body.dig('data', 'refresh_token'),
      scope: response_token_body.dig('data', 'scope'),
      expires_in: response_token_body.dig('data', 'expires_in'),
      refresh_expires_in: response_token_body.dig('data', 'refresh_expires_in'),
      error_code: response_token_body.dig('data', 'error_code')
    )
    response_token_body
  end
end
