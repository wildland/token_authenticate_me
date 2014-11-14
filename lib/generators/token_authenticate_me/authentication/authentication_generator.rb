module TokenAuthenticateMe
  module Generators
    class AuthenticationGenerator < ::Rails::Generators::NamedBase
      source_root File.expand_path('../templates', __FILE__)
      check_class_collision suffix: ''

      def create_authentication_model_file
        template 'model.rb', File.join('app/models', "#{singular_name}.rb")
      end
    end
  end
end
