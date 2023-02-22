# frozen_string_literal: true

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User

  has_many :campaign_participations, dependent: :destroy
  has_one :tiktok_access_token, dependent: :destroy
  has_one :user_profile, dependent: :destroy
  has_many :tiktok_movies, dependent: :destroy
  has_many :rewards, dependent: :destroy
  has_many :transfer_requests, dependent: :destroy

  delegate :line_user_id, to: :user_profile, allow_nil: true
  delegate :line_user_name, to: :user_profile, allow_nil: true

  DEVELOPMENT_REDIRECT_URL = 'https://4129-240f-76-14db-1-a024-e895-53eb-6b6f.jp.ngrok.io/tiktok_auth/registrations/callback'

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

  def rewards_sum
    rewards.sum(:amount)
  end

end
