require 'net/http'
require 'uri'

module Api::V1::LineTokenAuth::Concerns::LineAuthenticator
  extend ActiveSupport::Concern

  protected

  def authenticate(id_token)
    verify_result = verify_line_token(id_token)
    if verify_result[:code] != 200
      return fail_authenticate(verify_result[:code], verify_result[:body]["error_description"])
    end
    if verify_result[:body]["aud"] != line_channel_id
      return fail_authenticate(401, 'LINE Channel ID is not matched.')
    end
    success_authenticate({
      uid: verify_result[:body]["sub"],
      name: verify_result[:body]["name"],
      image: verify_result[:body]["picture"]
    })
  end

  private

  def line_channel_id
    @line_channel_id ||= ENV["LINE_LOGIN_CHANNEL_ID"]
  end

  def verify_line_token(id_token)
    uri = URI.parse("https://api.line.me/oauth2/v2.1/verify")
    uri.query = URI.encode_www_form({id_token: id_token, client_id: ENV['LINE_LOGIN_CHANNEL_ID']})
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    req = Net::HTTP::Post.new uri.request_uri
    res = http.request req
    {
      code: res.code.to_i,
      body: JSON.parse(res.body)
    }
  end

  def fail_authenticate(code, message)
    { error: { code: code, message: message }, profile: nil }
  end

  def success_authenticate(profile)
    { error: nil, profile: profile }
  end
end
