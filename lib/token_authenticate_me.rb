require 'token_authenticate_me/engine'
require 'token_authenticate_me/version'
require 'token_authenticate_me/configuration'

module TokenAuthenticateMe
  extend self

  UUID_REGEX = /([a-f0-9]){32}/

  module Concerns
    module Controllers
      autoload :Authenticatable, 'token_authenticate_me/concerns/controllers/authenticateable'
      autoload :Invitable, 'token_authenticate_me/concerns/controllers/invitable'
      autoload :PasswordResetable, 'token_authenticate_me/concerns/controllers/password_resetable'
      autoload :SessionAuthenticateable, 'token_authenticate_me/concerns/controllers/session_authenticateable'
      autoload :Sessionable, 'token_authenticate_me/concerns/controllers/sessionable'
      autoload :TokenAuthenticateable, 'token_authenticate_me/concerns/controllers/token_authenticateable'
      autoload :TokenSessionable, 'token_authenticate_me/concerns/controllers/token_sessionable'
    end

    module Models
      autoload :Authenticatable, 'token_authenticate_me/concerns/models/authenticatable'
      autoload :Invitable, 'token_authenticate_me/concerns/models/invitable'
      autoload :Sessionable, 'token_authenticate_me/concerns/models/sessionable'
    end
  end

  def configure
    yield configuration
  end

  def configuration
    Configuration.instance
  end
end
