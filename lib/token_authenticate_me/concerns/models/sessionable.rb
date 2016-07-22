require 'active_support/concern'

module TokenAuthenticateMe
  module Concerns
    module Models
      module Sessionable
        extend ActiveSupport::Concern

        included do
          belongs_to :user

          before_create :generate_unique_key

          def as_json(options={})
            { session: super({ include: :user }.merge(options)) }
          end

          def attributes
            {
              'key' => key,
              'expiration' => expiration,
              'created_at' => created_at,
              'updated_at' => updated_at
            }
          end

          private

          def generate_unique_key
            begin
              self.key = SecureRandom.hex
            end while self.class.exists?(key: key) # rubocop:disable Lint/Loop

            self.expiration = expiration_hours.hours.from_now
          end

          def expiration_hours
            24
          end
        end
      end
    end
  end
end
