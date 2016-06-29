require 'token_authenticate_me/models/invitable'


module TokenAuthenticateMe
  class Invite < ActiveRecord::Base
    include TokenAuthenticateMe::Models::Invitable

    def accept!(current_user)
      # no-op, override for app specific accept logic
    end
  end
end
