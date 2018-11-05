require 'active_support/concern'
require 'token_authenticate_me/concerns/models/passwordable'

module TokenAuthenticateMe
  module Concerns
    module Models
      module Authenticatable
        extend ActiveSupport::Concern
        include TokenAuthenticateMe::Concerns::Models::Passwordable

        included do

          has_many :sessions, dependent: :destroy

          before_save :downcase_email_and_username

          validates(
            :email,
            presence: true,
            uniqueness: { case_sensitive: false },
          )

          with_options if: :email_confirmation_required? do |model|
            model.validates :email, confirmation: true
            model.validates :email_confirmation, presence: true
          end

          validates(
            :email,
            format: {
              with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i,
              message: 'invalid e-mail address'
            },
            unless: :ignore_email_format_validation?
          )

          validates(
            :username,
            presence: true,
            uniqueness: { case_sensitive: false }
          )

          validates(
            :username,
            format: { with: /\A[a-zA-Z0-9]+\Z/ },
            unless: :ignore_username_format_validation?
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

          def as_json(options = nil)
            { user: super(options) }
          end

          def ignore_username_format_validation?
            false
          end

          def ignore_email_format_validation?
            false
          end

          def ignore_email_confirmation_on_change?
            true
          end

          protected

          def email_confirmation_required?
            !ignore_email_confirmation_on_change? && attempting_to_change_email?
          end

          def attempting_to_change_email?
            email_changed? && persisted?
          end

          def downcase_email_and_username
            self.email = email.downcase
            self.username = username.downcase
          end
        end
      end
    end
  end
end
