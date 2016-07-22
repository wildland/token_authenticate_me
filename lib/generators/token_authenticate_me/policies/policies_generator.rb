module TokenAuthenticateMe
  module Generators
    class PoliciesGenerator < ::Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)

      def create_invite_poliocy
        copy_file 'invite_policy.rb', 'app/policies/token_authenticate_me/invite_policy.rb'
      end

      def create_user_poliocy
        copy_file 'user_policy.rb', 'app/policies/token_authenticate_me/user_policy.rb'
      end
    end
  end
end
