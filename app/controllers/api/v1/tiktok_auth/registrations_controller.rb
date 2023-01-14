module Api::V1::TiktokAuth
  class RegistrationsController < ApplicationController

    CALLBACK_REDIRECT_URL = ENV['LIFF_URL']

    def new
      url = authenticate_url
    end

    def callback
      response_token_body = TiktokAccessToken.get_access_token(params[:code])
      user = User.find_by(uid: params[:user_uid])
      tiktok_access_token = TiktokAccessToken.create_by_token_response!(response_token_body, user)
      tiktok_user_info = tiktok_access_token.get_v2_user_info
      user.user_profile.update!(
        tiktok_user_name: tiktok_user_info.dig('data', 'user', 'display_name'),
        tiktok_user_image_url: tiktok_user_info.dig('data', 'user', 'avatar_url'),
        tiktok_open_id: tiktok_user_info.dig('data', 'user', 'open_id'),
        tiktok_union_id: tiktok_user_info.dig('data', 'user', 'union_id'),
        tiktok_profile_deep_link: tiktok_user_info.dig('data', 'user', 'profile_deep_link'),
      )
      redirect_to CALLBACK_REDIRECT_URL, allow_other_host: true
    end
  end
end
