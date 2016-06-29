require 'token_authenticate_me/controllers/sessionable'

module TokenAuthenticateMe
  module Api
    module V1
      class SessionsController < BaseController
        include TokenAuthenticateMe::Controllers::Sessionable
      end
    end
  end
end
