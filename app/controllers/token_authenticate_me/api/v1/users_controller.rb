require 'token_authenticate_me/concerns/controllers/token_authenticateable'
require 'api_me'

module TokenAuthenticateMe
  module Api
    module V1
      class UsersController < BaseController
        include ApiMe
        include TokenAuthenticateMe::Concerns::Controllers::TokenAuthenticateable

        skip_before_action :authenticate, only: [:create]

        model TokenAuthenticateMe::User
        serializer TokenAuthenticateMe::UserSerializer
      end
    end
  end
end
