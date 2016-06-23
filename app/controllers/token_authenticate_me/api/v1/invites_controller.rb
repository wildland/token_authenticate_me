require 'token_authenticate_me/controllers/invitable'

module TokenAuthenticateMe
  module Api
    module V1
      class InvitesController
        include TokenAuthenticateMe::Controllers::Invitable
      end
    end
  end
end
