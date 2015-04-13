require 'token_authenticate_me/models/sessionable'

class Session < ActiveRecord::Base
  include TokenAuthenticateMe::Models::Sessionable

  belongs_to :<%= authenticate_model_singular_name %>

  def as_json(options={})
    { <%= session_model_singular_name %>: super({ include: :<%= authenticate_model_singular_name %> }.merge(options)) }
  end

end
