require 'token_authenticate_me/concerns/controllers/password_resetable'

module TokenAuthenticateMe
  module Api
    module V1
      class PasswordResetsController < BaseController
        include TokenAuthenticateMe::Concerns::Controllers::PasswordResetable
      end
    end
  end
end
