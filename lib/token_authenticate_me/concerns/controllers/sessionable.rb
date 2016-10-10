require 'active_support/concern'
require 'token_authenticate_me/concerns/controllers/token_authenticateable'

module TokenAuthenticateMe
  module Concerns
    module Controllers
      module Sessionable
        extend ActiveSupport::Concern

        included do
          after_action :cleanup_sessions, only: [:create, :destroy]

          protected

          def unauthenticate_resource
            authenticated_session.destroy!
          end

          def create_session!(authenticated_resource)
            Session.create!(user_id: authenticated_resource.id)
          end

          def resource
            @resource ||= User.where('username=? OR email=?', session_params[:username], session_params[:username]).first
          end

          def authenticate_resource
            if resource && resource.authenticate(session_params[:password])
              resource
            else
              nil
            end
          end

          def cleanup_sessions
            Session.where('expiration < ?', DateTime.now).delete_all
          rescue
            Rails.logger.warn 'Error cleaning up old authentication sessions'
          end
        end
      end
    end
  end
end
