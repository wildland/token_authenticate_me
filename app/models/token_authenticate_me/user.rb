require 'token_authenticate_me/concerns/models/authenticatable'

module TokenAuthenticateMe
  class User < ActiveRecord::Base
    include TokenAuthenticateMe::Concerns::Models::Authenticatable

    def self.policy_class
      TokenAuthenticateMe::UserPolicy
    end
  end
end
