module TokenAuthenticateMe
  module Generators
    class InstallGenerator < Rails::Generators::Base
      def run_generators
        params = @_initializer[0]

        invoke 'token_authenticate_me:models', params
        invoke 'token_authenticate_me:controllers', params
        invoke 'api_me:policy', ['user', 'username', 'email', 'password', 'password_confirmation']
        invoke 'api_me:filter', ['user']
        invoke 'serializer', ['user', 'username', 'email', 'created_at', 'updated_at']

        inject_into_class Rails.root.join('app', 'policies', 'user_policy.rb'), UserPolicy do
          "  def create?\n    true\n  end\n"
        end
      end
    end
  end
end
