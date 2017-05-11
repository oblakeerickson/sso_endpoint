require 'roda'
require 'base64'
require 'openssl'

class App < Roda

  route do |r|
    r.get "sso" do
      sso = r['sso']
      sig = r['sig']
      decoded_sso = Base64.decode64(sso)
      sig_test = OpenSSL::HMAC.hexdigest("sha256", 'abcdefghij', sso)
      if sig_test == sig
        "match"
      else
        "not match"
      end
    end
  end
end
