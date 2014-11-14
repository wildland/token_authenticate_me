require 'active_support/concern'

module TokenAuthenticateMe
  module Controllers
    module TokenAuthenticable
      extend ActiveSupport::Concern

      included do
        before_action :authenticate
      end

      protected

      def authenticate
        authenticate_token || render_unauthorized
      end

      def current_user
        if authenticate_token
          @current_user ||= User.find_by_id(authenticate_token.user_id)
        else
          nil
        end
      end

      def authenticate_token
        @session ||= authenticate_with_http_token do |token, options|
          session = Session.find_by_key(token)
          if session && session.expiration > DateTime.now
            session
          else
            false
          end
        end
      end

      def render_unauthorized
        self.headers['WWW-Authenticate'] = 'Token realm="Application"'
        render json: 'Bad credentials', status: 401
      end
    end
  end
end
