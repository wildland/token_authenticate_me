require 'token_authenticate_me/concerns/controllers/invitable'

module TokenAuthenticateMe
  module Api
    module V1
      class InvitesController < BaseController
        include TokenAuthenticateMe::Concerns::Controllers::Invitable

        model TokenAuthenticateMe::Invite
        serializer TokenAuthenticateMe::InviteSerializer
      end
    end
  end
end
