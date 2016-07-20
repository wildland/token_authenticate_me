require 'token_authenticate_me/models/authenticatable'

module TokenAuthenticateMe
  class User < ActiveRecord::Base
    include TokenAuthenticateMe::Models::Authenticatable

    def self.policy_class
      TokenAuthenticateMe::UserPolicy
    end
  end
end
