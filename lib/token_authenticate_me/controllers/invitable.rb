require 'api_me'

module TokenAuthenticateMe
  module Controllers
    module Invitable
      extend ActiveSupport::Concern

      include TokenAuthenticateMe::Controllers::TokenAuthenticateable
      include ApiMe

      included do |base|

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

            render status: 204, nothing: true
          else
            render json: { message: "The request has already been processed" }, status: 422
          end
        end

        def decline
          @object = model_klass.find(params[:id])

          if @object.accepted.nil?
            @object.update!(accepted: false)
            render status: 204, nothing: true
          else
            render json: { message: "The request has already been processed" }, status: 422
          end
        end
      end
    end
  end
end
