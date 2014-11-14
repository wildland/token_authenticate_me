require 'token_authenticate_me'

class <%= class_name %> < ActiveRecord::Base
  include TokenAuthenticateMe::AuthenticationModel
  
end
