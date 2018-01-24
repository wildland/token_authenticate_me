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
          has_many :invites, inverse_of: 'creator', foreign_key: 'creator_id'

          before_save :downcase_email_and_username

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

          protected

          def downcase_email_and_username
            self.email = email.downcase
            self.username = username.downcase
          end
        end
      end
    end
  end
end
