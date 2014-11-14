require 'token_authenticate_me/authentication_model'

class <%= class_name %> < ActiveRecord::Base
  include TokenAuthenticateMe::AuthenticationModel

end
