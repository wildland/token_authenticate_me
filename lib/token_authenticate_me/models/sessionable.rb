require 'active_support/concern'

module TokenAuthenticateMe
  module Models
    module Sessionable
      extend ActiveSupport::Concern

      included do
        before_create :generate_unique_key

        private

        def generate_unique_key
          begin
            self.key = SecureRandom.hex
          end while self.class.exists?(key: self.key)

          self.expiration = expiration_hours.hours.from_now
        end

        def expiration_hours
          24
        end
      end
    end
  end
end
