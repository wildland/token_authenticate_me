# TODO: Update so path (/api) isn't fixed
module TokenAuthenticateMe
  module Generators
    class ControllersGenerator < ::Rails::Generators::NamedBase
      source_root File.expand_path('../templates', __FILE__)
      check_class_collision suffix: 'Controller'

      def create_sessions_controller
        template 'sessions.rb', 'app/controllers/api/sessions_controller.rb'

        # Inject /api/sesssion route into routes file
        insert_after_api("    resource :session, only: [:create, :show, :destroy]\n")
      end

      def create_password_reset_controller # rubocop:disable Metrics/MethodLength
        template 'password_reset.rb', 'app/controllers/api/password_resets_controller.rb'
        insert_after_api(<<-ROUTE
    resources(
      :password_resets,
      only: [:create, :update],
      constraints: {
        id: TokenAuthenticateMe::UUID_REGEX
      }
    )
ROUTE
        )
      end

      def create_users_controller
        template 'users.rb', 'app/controllers/api/v1/users_controller.rb'
        insert_after_version("      resources :users\n")
      end

      private

      def insert_after_api(string)
        maybe_create_api_v1_namespace

        in_root do
          insert_into_file(
            'config/routes.rb',
            string,
            after: "namespace :api do\n"
          )
        end
      end

      def insert_after_version(string)
        maybe_create_api_v1_namespace

        in_root do
          insert_into_file(
            'config/routes.rb',
            string,
            after: "namespace :v1 do\n"
          )
        end
      end

      def maybe_create_api_v1_namespace
        in_root do
          unless File.readlines('config/routes.rb').grep('namespace :api do')
            route <<-ROUTE
namespace :api do
    namespace :v1 do
    end
  end
ROUTE
          end
        end
      end

      def inject_before_actions_into_users_controllers
        inject_into_class(
          Rails.root.join('app', 'controllers', 'api', 'v1', 'users_controller.rb'),
          UsersController,
          "  skip_before_action :authenticate, only: [:create]\n"
        )
      end
    end
  end
end
