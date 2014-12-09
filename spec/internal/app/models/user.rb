require 'token_authenticate_me/models/authenticatable'

class User < ActiveRecord::Base
  include TokenAuthenticateMe::Models::Authenticatable

  has_many :sessions

  def as_json(options=nil)
    { user: super(options) }
  end
end
