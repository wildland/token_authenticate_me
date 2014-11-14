require 'token_authenticate_me/controllers/sessionable'

class <%= class_name %>SessionsController < ApplicationController
  include TokenAuthenticateMe::Controllers::Sessionable

end
