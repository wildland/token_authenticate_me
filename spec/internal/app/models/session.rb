require 'token_authenticate_me/models/sessionable'

class Session < ActiveRecord::Base
  include TokenAuthenticateMe::Models::Sessionable
end
