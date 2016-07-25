require 'active_support/concern'

module TokenAuthenticateMe
  module Controllers
    module TokenAuthenticateable
      extend ActiveSupport::Concern

      included do
        before_action :authenticate
      end

      protected

      def authenticate
        authenticate_token || authenticate_param || render_unauthorized
      end

      def current_user
        return @current_user if authenticate_token
        @current_user ||= User.find_by_id(authenticate_token.user_id)
      end

      def authenticate_token
        @session ||= authenticate_with_http_token do |token, _options|
          session = Session.find_by_key(token)
          if session && session.expiration > DateTime.now
            session
          else
            false
          end
        end
      end

      def authenticate_param
        token = params[:authentication_token]
        session = Session.find_by_key(token)
        if session && (session.expiration > DateTime.now)
          @session ||= session
        else
          @session ||= false
        end
      end

      def render_unauthorized
        headers['WWW-Authenticate'] = 'Token realm="Application"'
        render json: 'Bad credentials', status: 401
      end
    end
  end
end
