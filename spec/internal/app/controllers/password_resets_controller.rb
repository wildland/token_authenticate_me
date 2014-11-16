require 'token_authenticate_me/controllers/password_resetable'

class PasswordResetsController < ApplicationController
  include TokenAuthenticateMe::Controllers::PasswordResetable
end
