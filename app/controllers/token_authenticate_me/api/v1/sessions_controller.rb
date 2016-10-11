require 'token_authenticate_me/concerns/controllers/token_authenticateable'
require 'token_authenticate_me/concerns/controllers/token_sessionable'

module TokenAuthenticateMe
  module Api
    module V1
      class SessionsController < BaseController
        include TokenAuthenticateMe::Concerns::Controllers::TokenAuthenticateable
        include TokenAuthenticateMe::Concerns::Controllers::TokenSessionable
      end
    end
  end
end
