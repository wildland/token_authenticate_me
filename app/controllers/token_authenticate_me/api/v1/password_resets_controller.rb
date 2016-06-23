require 'token_authenticate_me/controllers/password_resetable'

module TokenAuthenticateMe
  module Api
    module V1
      class PasswordResetsController < ApplicationController
        include TokenAuthenticateMe::Controllers::PasswordResetable
      end
    end
  end
end
