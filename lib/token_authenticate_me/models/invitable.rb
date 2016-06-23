require 'active_support/concern'

module TokenAuthenticateMe
  module Models
    module Invitable
      extend ActiveSupport::Concern

      included do
        belongs_to :creator, class_name: User

        validates :requestor, presence: true
        validates :email, presence: true

        default_scope { order('created_at ASC') }
      end
    end
  end
end
