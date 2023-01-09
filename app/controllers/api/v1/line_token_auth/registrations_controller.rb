module Api::V1::LineTokenAuth
  class RegistrationsController < DeviseTokenAuth::RegistrationsController
    include Api::V1::LineTokenAuth::Concerns::LineAuthenticator

    def create

      build_resource

      auth_result = authenticate(sign_up_params[:id_token])
      if auth_result[:error]
        return render_error(auth_result[:error][:code], auth_result[:error][:message])
      end

      @resource.uid = auth_result[:profile][:uid]
      @resource.line_user_id = auth_result[:profile][:uid]
      @resource.line_user_name = auth_result[:profile][:name]
      @resource.line_user_image = auth_result[:profile][:image]

      ActiveRecord::Base.transaction do
        if active_for_authentication?
            @token = @resource.create_token
            @resource.save!

            # UserProfile.create!(user_id: @resource.id, line_user_id: @resource.uid, account_name: auth_result[:profile][:name])
          update_auth_header
        end

        render_create_success
      end
    rescue => e
      clean_up_passwords @resource
      render_create_error
    end

    protected

    def build_resource
      @resource            = resource_class.new
      @resource.provider   = provider
    end

    private

    def provider
      'line'
    end

    def client
      @client ||= Line::Bot::Client.new do |config|
        config.channel_secret = ENV['LINE_CHANNEL_SECRET']
        config.channel_token = ENV['LINE_ACCESS_TOKEN']
      end
    end
  end
end
