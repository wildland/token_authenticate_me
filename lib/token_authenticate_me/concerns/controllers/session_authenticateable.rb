require 'active_support/concern'
require 'token_authenticate_me/concerns/controllers/authenticateable'
require 'token_authenticate_me/session_authentication'

# This module provides cookie based session authentication for server rendered pages.
# If using this module, make sure CSRF is enabled to prevent CSRF attacks.

module TokenAuthenticateMe
  module Concerns
    module Controllers
      module SessionAuthenticateable
        extend ActiveSupport::Concern

        include TokenAuthenticateMe::Concerns::Controllers::Authenticateable

        protected

        def authenticated_session
          @session ||= authenticate_with_session
        end

        def authenticate_with_session
          session_authentication = TokenAuthenticateMe::SessionAuthentication.new(controller: self)
          session_authentication.authenticate
        end

        def return_to_url
          session[:return_to]
        end

        def save_return_to_url
          session[:return_to] = request.url
        end

        def redirect_to_login
          redirect_to login_url
        end

        def render_unauthorized
          save_return_to_url
          flash.now[:error] = "You must be logged in to access this section"
          redirect_to_login
        end
      end
    end
  end
end
