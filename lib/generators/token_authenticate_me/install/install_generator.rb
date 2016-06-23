module TokenAuthenticateMe
  module Generators
    class InstallGenerator < Rails::Generators::Base
      def run_generators
        invoke 'form_me:install:migrations'
        invoke 'token_authenticate_me:models'
        invoke 'token_authenticate_me:controllers'
        invoke 'token_authenticate_me:policies'
        invoke 'serializer', %w(user username email created_at updated_at)
        invoke 'serializer', %w(invite email accepted meta creator:has_one created_at updated_at)
      end

      def mount_engine_routes
        route 'mount TokenAuthenticateMe::Engine => TokenAuthenticateMe.configuration.mount_path'
      end
    end
  end
end
