module TokenAuthenticateMe
  class ParamAuthentication
    attr :controller

    def initialize(controller:)
      @controller = controller
    end

    def authenticate(options = {})
      token_handler(token, options)
    end

    private

    def token
      controller.params[:authentication_token]
    end

    def token_handler(token, options)
      controller.token_handler(token, options)
    end
  end
end

