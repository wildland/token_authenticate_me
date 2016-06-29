require 'token_authenticate_me/controllers/token_authenticateable'

module TokenAuthenticateMe
  module Api
    module V1
      class UsersController < BaseController
        include ApiMe
        include TokenAuthenticateMe::Controllers::TokenAuthenticateable

        skip_before_action :authenticate, only: [:create]

        model TokenAuthenticateMe::User
        serializer TokenAuthenticateMe::UserSerializer
      end
    end
  end
end
