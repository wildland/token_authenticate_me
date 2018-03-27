require 'active_support/concern'

module TokenAuthenticateMe
  module Concerns
    module Models
      module Passwordable
        extend ActiveSupport::Concern

        included do
          has_secure_password validations: false
          attr_accessor :current_password

          validates(
            :password,
            presence: true,
            confirmation: true,
            if: :password_required?
          )

          validates(
            :password_confirmation,
            presence: true,
            if: :password_required?
          )

          validates(
            :password,
            length: { in: 8..72 },
            if: :password_required?,
            unless: :ignore_password_length_validations?
          )

          validate(
            :current_password_correct,
            if: :current_password_required?
          )

          def create_reset_token!
            # rubocop:disable Lint/Loop
            begin
              self.reset_password_token = SecureRandom.hex
            end while self.class.exists?(reset_password_token: reset_password_token)

            self.reset_password_token_exp = password_expiration_hours.hours.from_now
            save!
          end

          def password_expiration_hours
            8
          end

          def password=(unencrypted_password)
            super(unencrypted_password) unless unencrypted_password.blank? && !password_required?
          end

          def current_password_correct
            user_with_old_password = self.class.find_by_id(id)
            errors.add(:current_password, 'is required to change email and/or password') if current_password.blank? # rubocop:disable Metrics/LineLength
            errors.add(:current_password, 'is incorrect') unless user_with_old_password.authenticate(current_password)
          end

          def current_password_required?
            !new_record? && (email_changed? || attempting_to_change_password?) && !password_resetting?
          end

          def password_resetting?
            reset_password_token_changed? && reset_password_token_exp_changed?
          end

          def ignore_password_length_validations?
            false
          end

          def ignore_password_length_validations?
            false
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
