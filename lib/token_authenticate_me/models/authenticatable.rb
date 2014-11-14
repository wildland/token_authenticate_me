require 'active_support/concern'

module TokenAuthenticateMe
  module Models
    module Authenticatable
      extend ActiveSupport::Concern

      included do
        has_secure_password

        validates(
          :email,
          presence: true,
          uniqueness: { case_sensitive: false }
        )

        validates(
          :username,
          format: { with: /\A[a-zA-Z0-9]+\Z/ },
          presence: true,
          uniqueness: { case_sensitive: false }
        )

        def create_reset_token
          begin
            self.reset_token = SecureRandom.hex
          end while self.class.exists?(reset_token: reset_token)

          self.reset_token_exp = password_expiration_hours.hours.from_now
          self.save!
        end
      end
    end
  end
end
