require 'roda'
require 'base64'
require 'openssl'
require 'uri'
require 'securerandom'

class App < Roda

  route do |r|
    r.get "sso" do
      sso = r['sso']
      sig = r['sig']
      sig_test = OpenSSL::HMAC.hexdigest("sha256", 'abcdefghij', sso)
      if sig_test != sig
        return "error"
      else
        base64_sso = URI.unescape(sso)
        decoded_sso = Base64.decode64(base64_sso)
        params = Rack::Utils.parse_nested_query(decoded_sso)
        nonce = params['nonce']
        return_sso_url = params['return_sso_url']
        external_id = rand 1000
        username = SecureRandom.hex
        payload = {
          "nonce" => nonce,
          "name" => username,
          "external_id" => external_id,
          "email" => "#{username}@test.com",
          "username" => username,
          "require_activation" => "true"
        }
        payload = Rack::Utils.build_query(payload)
        base64_payload = Base64.encode64(payload)
        encoded_payload = URI.escape(base64_payload)
        new_sig = OpenSSL::HMAC.hexdigest("sha256", 'abcdefghij', base64_payload)
        r.redirect "http://192.168.56.2:3000/session/sso_login?sso=#{encoded_payload}&sig=#{new_sig}"
      end
    end
  end
end
