module TokenAuthenticateMe
  class SessionAuthentication
    attr :controller

    def initialize(controller:)
      @controller = controller
    end

    def authenticate(options = {})
      token = session_key
      token_handler(token, options)
    end

    private

    def token_handler(token, options)
      controller.token_handler(token, options)
    end

    def session_key
      controller.session[:key]
    end
  end
end
