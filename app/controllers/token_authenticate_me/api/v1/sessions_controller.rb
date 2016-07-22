require 'token_authenticate_me/concerns/controllers/sessionable'

module TokenAuthenticateMe
  module Api
    module V1
      class SessionsController < BaseController
        include TokenAuthenticateMe::Concerns::Controllers::Sessionable
      end
    end
  end
end
