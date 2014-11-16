require 'active_support/concern'

require 'token_authenticate_me/controllers/token_authenticateable'

module TokenAuthenticateMe
  module Controllers
    module Sessionable
      extend ActiveSupport::Concern

      include TokenAuthenticateMe::Controllers::TokenAuthenticateable

      included do
        skip_before_action :authenticate, only: [:create]
        after_action :cleanup_sessions, only: [:destroy]

        def create
          resource = User.where('username=? OR email=?', params[:username], params[:username]).first
          if resource && resource.authenticate(params[:password])
            @session = Session.create(user_id: resource.id)
            render json: serialize_session(@session), status: 201
          else
            render json: { message: 'Bad credentials' }, status: 401
          end
        end

        def show
          @session = authenticate_token
          render json: serialize_session(@session)
        end

        def destroy
          authenticate_token.destroy

          render status: 204, nothing: true
        rescue
          render_unauthorized
        end

        private

        def serialize_session(session)
          {
            session: {
              key: session.key,
              user_id: session.user_id,
              expiration: session.expiration
            }
          }
        end

        def session_params
          params.permit(:username, :email, :password)
        end

        def cleanup_sessions
          ApiSession.where('expiration < ?', DateTime.now).delete_all
        rescue
          Rails.logger.warn 'Error cleaning up old authentication sessions'
        end
      end
    end
  end
end
