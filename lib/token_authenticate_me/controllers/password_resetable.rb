require 'active_support/concern'

require 'token_authenticate_me/controllers/token_authenticateable'

module TokenAuthenticateMe
  module Controllers
    module PasswordResetable
      extend ActiveSupport::Concern

      included do
        include TokenAuthenticateMe::Controllers::TokenAuthenticateable

        skip_before_action :authenticate, only: [:create, :update]
        before_action :validate_reset_token, only: [:update]

        # Send reset token to user with e-mail address
        def create
          @user = User.find_by_email(params[:email])

          if @user
            send_valid_reset_email(@user)
          else
            send_invalid_reset_email(params[:email])
          end

          render status: 204, nothing: true
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

          render status: 204, nothing: true
        rescue ActiveRecord::RecordInvalid => e
          handle_errors(e)
        end

        private

        def send_valid_reset_email(user)
          user.create_reset_token!

          TokenAuthenticateMeMailer.valid_user_reset_password_email(
            request.base_url,
            user
          ).deliver
        end

        def send_invalid_reset_email(email)
          TokenAuthenticateMeMailer.invalid_user_reset_password_email(
            request.base_url,
            email
          ).deliver
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
          render status: 404, nothing: true
        end

        def valid_reset_token?
          @user = User.find_by_reset_password_token(params[:id])

          @user && @user.reset_password_token_exp > DateTime.now
        end
      end
    end
  end
end
