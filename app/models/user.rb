# frozen_string_literal: true

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User

  has_many :campaign_participations
  has_one :tiktok_access_token
  has_one :user_profile

  DEVELOPMENT_REDIRECT_URL = 'https://41c3-240f-76-14db-1-4941-7731-936c-4561.jp.ngrok.io/api/v1/tiktok_auth/registrations/callback'

  def token_validation_response
    {
      user: {
        tiktok_integration_status: tiktok_integration_status,
        tiktok_integration_url: tiktok_integration_url,
        user_profile: {
          tiktok_user_name: user_profile.tiktok_user_name,
          tiktok_user_image_url: user_profile.tiktok_user_image_url,
        }
      }
    }
  end

  def tiktok_integration_status
     tiktok_access_token.present?
  end

  def tiktok_integration_url
    redirect_uri = Rails.env.development? ? DEVELOPMENT_REDIRECT_URL : Rails.application.routes.url_helpers.tiktok_auth_registrations_callback_url(protocol: 'https')
    redirect_uri = "#{redirect_uri}?user_uid=#{uid}"
    base_url = 'https://www.tiktok.com/auth/authorize/'
    base_url = base_url + "?client_key=#{ENV['TIKTOK_KEY']}"
    base_url = base_url + "&scope=user.info.basic,video.list"
    base_url = base_url + "&response_type=code"
    base_url = base_url + "&redirect_uri=#{redirect_uri}"
    base_url
  end
end
