# frozen_string_literal: true

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User

  has_many :campaign_participations
  has_one :tiktok_access_token
  has_one :user_profile, dependent: :destroy
  has_many :tiktok_movies, dependent: :destroy
  has_many :rewards, dependent: :destroy

  delegate :line_user_id, to: :user_profile
  delegate :line_user_name, to: :user_profile

  DEVELOPMENT_REDIRECT_URL = 'https://41c3-240f-76-14db-1-4941-7731-936c-4561.jp.ngrok.io/api/v1/tiktok_auth/registrations/callback'

  def tiktok_integration_status
     tiktok_access_token.present?
  end

  def tiktok_integration_url
    redirect_uri = Rails.env.development? ? DEVELOPMENT_REDIRECT_URL : Rails.application.routes.url_helpers.tiktok_auth_registrations_callback_url(protocol: 'https')
    redirect_uri = "#{redirect_uri}%3Fuser_uid=#{uid}"
    base_url = 'https://www.tiktok.com/auth/authorize/'
    base_url = base_url + "?client_key=#{ENV['TIKTOK_KEY']}"
    base_url = base_url + "&scope=user.info.basic,video.list"
    base_url = base_url + "&redirect_uri=#{redirect_uri}"
    base_url = base_url + "&response_type=code"
    base_url
  end
end
