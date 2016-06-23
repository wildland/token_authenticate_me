module TokenAuthenticateMe
  module Generators
    class PoliciesGenerator < ::Rails::Generators::NamedBase
      source_root File.expand_path('../templates', __FILE__)
      check_class_collision suffix: ''

      def create_invite_poliocy
        create_file 'invite_policy.rb', "app/policies/token_authenticate_me/#{file_name}.rb"
      end

      def create_user_poliocy
        create_file 'invite_policy.rb', "app/policies/token_authenticate_me/#{file_name}.rb"
      end
    end
  end
end
