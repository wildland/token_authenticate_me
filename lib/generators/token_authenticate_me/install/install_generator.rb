module TokenAuthenticateMe
  module Generators
    class InstallGenerator < Rails::Generators::Base
      def run_generators
        rake 'token_authenticate_me:install:migrations'
        generate 'token_authenticate_me:models'
        generate 'token_authenticate_me:controllers'
        generate 'token_authenticate_me:policies'
        generate 'serializer token_authenticate_me/user username email created_at updated_at'
        generate 'serializer token_authenticate_me/invite email accepted meta creator:has_one created_at updated_at'
      end

      def mount_engine_routes
        route 'mount TokenAuthenticateMe::Engine => TokenAuthenticateMe.configuration.mount_path'
      end
    end
  end
end
