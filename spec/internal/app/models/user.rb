require 'token_authenticate_me/models/authenticatable'

class User < ActiveRecord::Base
  include TokenAuthenticateMe::Models::Authenticatable
end
