module Api::V1::LineTokenAuth
  class SessionsController < DeviseTokenAuth::SessionsController
    include Api::V1::LineTokenAuth::Concerns::LineAuthenticator

    def create
      auth_result = authenticate(resource_params[:id_token])
      @resource = User.find_by(uid: auth_result[:profile][:uid])
      if @resource && (!@resource.respond_to?(:active_for_authentication?) || @resource.active_for_authentication?)
        if auth_result[:error]
          return render_error(auth_result[:error][:code], auth_result[:error][:message])
        end

        @resource.line_user_name = auth_result[:profile][:name]
        @resource.line_user_image = auth_result[:profile][:image]

        @token = @resource.create_token
        @resource.save

        sign_in(:user, @resource, store: false, bypass: false)

        yield @resource if block_given?
        render_create_success
      elsif @resource && !(!@resource.respond_to?(:active_for_authentication?) || @resource.active_for_authentication?)
        if @resource.respond_to?(:locked_at) && @resource.locked_at
          render_create_error_account_locked
        else
          render_create_error_not_confirmed
        end
      else
        render_create_error_bad_credentials
      end
    rescue => e
      render json: { status: 500, message: e.message }
    end

    def valid_params?(key, val)
      resource_params[:id_token] && key && val
    end

    def provider
      'line'
    end
  end
end
