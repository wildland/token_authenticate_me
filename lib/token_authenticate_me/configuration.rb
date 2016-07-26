require 'singleton'

module TokenAuthenticateMe
  class Configuration
    include Singleton

    attr_accessor :mount_path, :signup_path, :reset_path, :invite_path

    def initialize
      self.mount_path = 'token_authenticate_me'
      self.signup_path = '/sign-up'
      self.reset_path = '/reset-password/:token/'
      self.invite_path = '/invite/:id/'
    end
  end
end
