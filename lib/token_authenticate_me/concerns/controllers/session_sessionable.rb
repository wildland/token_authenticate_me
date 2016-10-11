require 'active_support/concern'
require 'token_authenticate_me/concerns/controllers/sessionable'

module TokenAuthenticateMe
  module Concerns
    module Controllers
      module SessionSessionable
        extend ActiveSupport::Concern

        include Sessionable

        included do
          skip_before_action :authenticate, only: [:new, :create]

          def new
          end

          def create
            if authenticate_resource
              @session = create_session!(resource)
              session[:key] = @session.key
              if return_to_url
                redirect_to_login
              else
                redirect_to root_url
              end
            else
              flash.now[:error] = "Invalid username or password"
              redirect_to_login
            end
          end

          def destroy
            unauthenticate_resource
            redirect_to return_to_url

          rescue
            render_unauthorized
          end

          protected

          def session_params
            params.require(:session).permit(:username, :password)
          end
        end
      end
    end
  end
end
