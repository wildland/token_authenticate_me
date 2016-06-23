require 'token_authenticate_me/models/invitable'


module TokenAuthenticateMe
  class Invite < ActiveRecord::Base
    include TokenAuthenticateMe::Models::Invitable
  end
end
