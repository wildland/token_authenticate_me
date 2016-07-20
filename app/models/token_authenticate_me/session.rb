require 'token_authenticate_me'
require 'token_authenticate_me/models/sessionable'

module TokenAuthenticateMe
  class Session < ActiveRecord::Base
    include TokenAuthenticateMe::Models::Sessionable
  end
end
