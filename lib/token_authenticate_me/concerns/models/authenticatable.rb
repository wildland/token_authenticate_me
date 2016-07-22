require 'active_support/concern'

module TokenAuthenticateMe
  module Concerns
    module Models
      module Authenticatable
        extend ActiveSupport::Concern

        included do
          has_secure_password validations: false
          attr_accessor :current_password

          has_many :sessions
          has_many :invites, inverse_of: 'creator', foreign_key: 'creator_id'


          validates(
            :email,
            presence: true,
            uniqueness: { case_sensitive: false },
            format: {
              with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i,
              message: 'invalid e-mail address'
            }
          )

          validates(
            :username,
            format: { with: /\A[a-zA-Z0-9]+\Z/ },
            presence: true,
            uniqueness: { case_sensitive: false }
          )

          validates(
            :password,
            presence: true,
            length: { in: 8..72 },
            confirmation: true,
            if: :password_required?
          )

          validate(
            :current_password_correct,
            if: :current_password_required?
          )

          def attributes
            {
              'id' => id,
              'username' => username,
              'email' => email,
              'created_at' => created_at,
              'updated_at' => updated_at
            }
          end

          def as_json(options=nil)
            { user: super(options) }
          end

          def create_reset_token!
            # rubocop:disable Lint/Loop
            begin
              self.reset_password_token = SecureRandom.hex
            end while self.class.exists?(reset_password_token: reset_password_token)

            self.reset_password_token_exp = password_expiration_hours.hours.from_now
            self.save!
          end

          def password_expiration_hours
            8
          end

          def password=(unencrypted_password)
            super(unencrypted_password) unless unencrypted_password.blank? && !password_required?
          end

          def current_password_correct
            errors.add(:current_password, 'is required to change email and/or password') if current_password.blank? # rubocop:disable Metrics/LineLength
            errors.add(:current_password, 'is incorrect') unless authenticate(current_password)
          end

          def current_password_required?
            !new_record? && (email_changed? || attempting_to_change_password?) && !password_resetting?
          end

          def password_resetting?
            reset_password_token_changed? && reset_password_token_exp_changed?
          end

          def password_required?
            attempting_to_change_password? || new_record?
          end

          def attempting_to_change_password?
            (!password.blank? || !password_confirmation.blank?) && password_digest_changed?
          end
        end
      end
    end
  end
end
