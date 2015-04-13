require 'token_authenticate_me/models/authenticatable'

class User < ActiveRecord::Base
  include TokenAuthenticateMe::Models::Authenticatable

  has_many :<%= session_model_plural_name %>

  def as_json(options=nil)
    { <%= authenticate_model_singular_name %>: super(options) }
  end
end
