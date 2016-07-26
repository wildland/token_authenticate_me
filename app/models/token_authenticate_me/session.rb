require 'token_authenticate_me'
require 'token_authenticate_me/concerns/models/sessionable'

module TokenAuthenticateMe
  class Session < ActiveRecord::Base
    include TokenAuthenticateMe::Concerns::Models::Sessionable
  end
end
