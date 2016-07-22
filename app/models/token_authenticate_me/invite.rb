require 'token_authenticate_me/concerns/models/invitable'


module TokenAuthenticateMe
  class Invite < ActiveRecord::Base
    include TokenAuthenticateMe::Concerns::Models::Invitable

    def accept!(current_user)
      # no-op, override for app specific accept logic
    end
  end
end
