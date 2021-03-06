require 'active_support/concern'
require 'token_authenticate_me/concerns/controllers/authenticateable'
require 'token_authenticate_me/header_authentication'
require 'token_authenticate_me/param_authentication'

module TokenAuthenticateMe
  module Concerns
    module Controllers
      module TokenAuthenticateable
        extend ActiveSupport::Concern

        include TokenAuthenticateMe::Concerns::Controllers::Authenticateable

        protected

        def authenticated_session
          @session ||= (authenticate_with_header || authenticate_with_params)
        end

        def authenticate_with_header
          header_authentication = TokenAuthenticateMe::HeaderAuthentication.new(controller: self)
          header_authentication.authenticate
        end

        def authenticate_with_params
          header_authentication = TokenAuthenticateMe::ParamAuthentication.new(controller: self)
          header_authentication.authenticate
        end

        def render_unauthorized
          headers['WWW-Authenticate'] = 'Token realm="Application"'
          render json: 'Bad credentials', status: 401
        end
      end
    end
  end
end
