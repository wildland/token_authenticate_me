require 'active_support/concern'
require 'token_authenticate_me/authentication'

module TokenAuthenticateMe
  module Concerns
    module Controllers
      module Authenticateable
        extend ActiveSupport::Concern
        
        included do
          before_action :authenticate # By default authenticate every action
        end

        # Standard authentication routine, override to implement different auth strategies.
        def token_handler(token, options)
          authentication = TokenAuthenticateMe::Authentication.new(token: token)
          authentication.authenticate(options)
        end

        protected

        # `authenticated_session` and `render_unauthorized` are specific to controllers.
        # Ex:
        # Could render json or http status code for unauthorized, or could redirect to a different url for server rendered pages.
        # Could authenticate using headers or params, or cookie sessions depending on controller type.
        def authenticate
          authenticated_session || render_unauthorized
        end

        def current_user
          return unless authenticated_session
          @current_user ||= User.find_by_id(authenticated_session.user_id)
        end
      end
    end
  end
end
