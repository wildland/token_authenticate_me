require 'active_support/concern'
require 'token_authenticate_me/concerns/controllers/sessionable'

module TokenAuthenticateMe
  module Concerns
    module Controllers
      module TokenSessionable
        extend ActiveSupport::Concern

        include Sessionable

        included do
          skip_before_action :authenticate, only: [:create]

          def create
            if authenticate_resource
              @session = create_session!(resource)
              render json: @session, status: 201
            else
              render json: { message: 'Bad credentials' }, status: 401
            end
          end

          def show
            @session = authenticated_session
            render json: @session
          end

          def destroy
            unauthenticate_resource

            head 204 # rails 5.2 styntax that renders a 204 status and no body
          rescue
            render_unauthorized
          end

          protected

          def session_params
            params.permit(:username, :password)
          end
        end
      end
    end
  end
end
