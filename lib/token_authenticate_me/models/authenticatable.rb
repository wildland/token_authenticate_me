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
      end
    end
  end
end
