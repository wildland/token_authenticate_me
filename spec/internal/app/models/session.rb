require 'token_authenticate_me/models/sessionable'

class Session < ActiveRecord::Base
  include TokenAuthenticateMe::Models::Sessionable

  belongs_to :user

  def as_json(options={})
    { session: super({ include: :user }.merge(options)) }
  end
end
