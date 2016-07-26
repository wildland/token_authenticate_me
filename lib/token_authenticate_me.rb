require 'token_authenticate_me/engine'
require 'token_authenticate_me/version'
require 'token_authenticate_me/configuration'

module TokenAuthenticateMe
  extend self

  UUID_REGEX = /([a-f0-9]){32}/

  def configure
    yield configuration
  end

  def configuration
    Configuration.instance
  end
end
