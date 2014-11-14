# TODO: Update so path (api/v1) isn't fixed
module TokenAuthenticateMe
  module Generators
    class ControllersGenerator < ::Rails::Generators::NamedBase
      source_root File.expand_path('../templates', __FILE__)
      check_class_collision suffix: 'Controller'

      def create_sessions_controller
        template 'sessions.rb', 'app/controllers/api/v1/sessions_controller.rb'
      end

      def create_password_reset_controller
        template 'password_reset.rb', 'app/controllers/api/v1/password_resets_controller.rb'
      end
    end
  end
end
