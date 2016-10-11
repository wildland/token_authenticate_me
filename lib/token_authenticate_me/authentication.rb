module TokenAuthenticateMe
  class Authentication
    def self.default_token_handler(token, _options)
      session = TokenAuthenticateMe::Session.find_by_key(token)

      if session && session.expiration > DateTime.now
        session
      else
        false
      end
    end

    attr_reader :token, :token_handler

    def initialize(token:, token_handler: TokenAuthenticateMe::Authentication.method(:default_token_handler))
      @token = token
      @token_handler = token_handler
    end

    def authenticate(options = {})
      token_handler.call(token, options)
    end
  end
end
