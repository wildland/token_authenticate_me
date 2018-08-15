require 'api_me'

module TokenAuthenticateMe
  module Concerns
    module Controllers
      module Invitable
        extend ActiveSupport::Concern

        include TokenAuthenticateMe::Concerns::Controllers::TokenAuthenticateable
        include ApiMe

        included do |_base|
          skip_before_action :authenticate, only: [:show]

          def create
            @object = model_klass.new(object_params)
            authorize @object
            @object.save!(object_params)

            TokenAuthenticateMeMailer.invite_email(
              @objec5,
              request.base_url
            ).deliver_later
            render status: 201, json: @object, serializer: serializer_klass
          rescue ActiveRecord::RecordInvalid => e
            handle_errors(e)
          end

          def accept
            @object = model_klass.find(params[:id])

            if @object.accepted.nil?
              ActiveRecord::Base.transaction do
                @object.accept!(current_user)
                @object.update!(accepted: true)
              end

              if Rails::VERSION::MAJOR < 5 && Rails::VERSION::MINOR < 2 # version < 5.2
                render status: 204, nothing: true
              else
                head 204 # rails 5.2 styntax that renders a 204 status and no body
              end
            else
              render json: { message: 'The request has already been processed' }, status: 422
            end
          end

          def decline
            @object = model_klass.find(params[:id])

            if @object.accepted.nil?
              @object.update!(accepted: false)

              if Rails::VERSION::MAJOR < 5 && Rails::VERSION::MINOR < 2 # version < 5.2
                render status: 204, nothing: true
              else
                head 204 # rails 5.2 styntax that renders a 204 status and no body
              end
            else
              render json: { message: 'The request has already been processed' }, status: 422
            end
          end
        end
      end
    end
  end
end
