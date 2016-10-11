require 'active_support/concern'
require 'token_authenticate_me/concerns/controllers/authenticateable'
require 'token_authenticate_me/header_authentication'

module TokenAuthenticateMe
  module Concerns
    module Controllers
      module TokenAuthenticateable
        extend ActiveSupport::Concern

        include TokenAuthenticateMe::Concerns::Controllers::Authenticateable

        included do
          before_action :authenticate # By default authenticate every action
        end


        protected

        def authenticated_session
          @session ||= authenticate_with_header
        end

        def authenticate_with_header
          header_authentication = TokenAuthenticateMe::HeaderAuthentication.new(controller: self)
          header_authentication.authenticate
        end

        def authenticate_with_params
          token = params[:authentication_token]
          token_handler(token, {})
        end

        def render_unauthorized
          headers['WWW-Authenticate'] = 'Token realm="Application"'
          render json: 'Bad credentials', status: 401
        end
      end
    end
  end
end
