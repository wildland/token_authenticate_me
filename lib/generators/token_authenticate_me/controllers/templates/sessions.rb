require 'token_authenticate_me/controllers/sessionable'

class SessionsController < ApplicationController
  include TokenAuthenticateMe::Controllers::Sessionable

end
