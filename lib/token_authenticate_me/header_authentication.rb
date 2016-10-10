module TokenAuthenticateMe
  class HeaderAuthentication
    attr :controller

    def initialize(controller:)
      @controller = controller
    end

    def authenticate(options = {})
      controller.authenticate_with_http_token(&method(:token_handler))
    end

    private

    def token_handler(token, options)
      token_handler = controller.token_handler(token, options)
    end
  end
end

