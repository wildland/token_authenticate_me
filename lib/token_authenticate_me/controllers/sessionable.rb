require 'active_support/concern'

require 'token_authenticate_me/controllers/token_authenticateable'

module TokenAuthenticateMe
  module Controllers
    module Sessionable
      extend ActiveSupport::Concern

      include TokenAuthenticateable

      included do
        serialization_scope nil

        skip_before_action :authenticate, only: [:create]
        after_action :cleanup_sessions

        def create
          resource = User.where('username=? OR email=?', params[:username], params[:email]).first
          if resource && resource.authenticate(params[:password])
            @session = Session.create(user_id: user.id)
            render json: @session
          else
            render json: {message: 'Bad credentials'}, status: 401
          end

        end

        def show
          @session = authenticate_token
          render json: @session
        end

        def destroy
          begin
            authenticate_token.destroy()

            render status: 204, nothing: true
          rescue
            render_unauthorized
          end
        end

        private

        def session_params
          params.permit(:username, :email, :password)
        end

        def cleanup_sessions
          begin
            # TODO: implement cleanup routine (async would be best)
          rescue
            Rails.logger.warn "Error cleaning up old authentication sessions"
          end
        end
      end
    end
  end
end
