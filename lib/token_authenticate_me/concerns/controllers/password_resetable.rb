require 'active_support/concern'

require 'token_authenticate_me/concerns/controllers/token_authenticateable'

module TokenAuthenticateMe
  module Concerns
    module Controllers
      module PasswordResetable
        extend ActiveSupport::Concern

        include TokenAuthenticateMe::Concerns::Controllers::TokenAuthenticateable

        included do
          skip_before_action :authenticate, only: [:create, :update]
          before_action :validate_reset_token, only: [:update]

          # Send reset token to user with e-mail address
          def create
            @user = User.find_by_email(email)

            if (/@/ =~ params[:email]) == nil
              render status: 422, json: { errors: { email: ['The email address is invalid'] } }
            else
              if @user
                send_valid_reset_email(@user)
              else
                send_invalid_reset_email(params[:email])
              end

              head 204 # rails 5.2 styntax that renders a 204 status and no body
            end
          end

          # Allow user to reset password when the token is valid
          # and not expired
          def update
            @user.update!(
              password: params[:password],
              password_confirmation: params[:password_confirmation],
              reset_password_token: nil,
              reset_password_token_exp: nil
            )

            head 204 # rails 5.2 styntax that renders a 204 status and no body
          rescue ActiveRecord::RecordInvalid => e
            handle_errors(e)
          end

          private

          def email
            params[:email].blank? ? '' : params[:email].downcase
          end

          def send_valid_reset_email(user)
            user.create_reset_token!

            TokenAuthenticateMeMailer.valid_user_reset_password_email(
              request.base_url,
              user
            ).deliver_later
          end

          def send_invalid_reset_email(email)
            TokenAuthenticateMeMailer.invalid_user_reset_password_email(
              request.base_url,
              email
            ).deliver_later
          end

          def session_params
            params.permit(:password, :password_confirmation)
          end

          def render_errors(errors, status = 422)
            render(json: { errors: errors }, status: status)
          end

          def handle_errors(e)
            render_errors(e.record.errors.messages)
          end

          def validate_reset_token
            valid_reset_token? || render_not_found
          end

          def render_not_found
            head 404 # rails 5.2 styntax that renders a 404 status and no body
          end

          def valid_reset_token?
            # Check for
            # https://github.com/rails/rails/commit/e8572cf2f94872d81e7145da31d55c6e1b074247
            # security issue when config.action_dispatch.perform_deep_munge = false is set
            # which is common for JSON APIs
            return false if params[:id].class == Array || params[:id].nil?

            @user = User.find_by_reset_password_token(params[:id])
            @user && @user.reset_password_token_exp > DateTime.now
          end
        end
      end
    end
  end
end
