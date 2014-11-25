# TODO: Update so path (/api) isn't fixed
module TokenAuthenticateMe
  module Generators
    class ControllersGenerator < ::Rails::Generators::NamedBase
      source_root File.expand_path('../templates', __FILE__)
      check_class_collision suffix: 'Controller'

      def create_sessions_controller
        template 'sessions.rb', 'app/controllers/api/sessions_controller.rb'

        # Inject /api/sesssion route into routes file
        route <<-ROUTE
namespace :api do
    resource :session, only: [:create, :show, :destroy]
  end
        ROUTE
      end

      def create_password_reset_controller # rubocop:disable Metrics/MethodLength
        template 'password_reset.rb', 'app/controllers/api/password_resets_controller.rb'

        # Inject /api/password_resets route into routes file
        route <<-ROUTE
namespace :api do
    resources(
      :password_resets,
      only: [:create, :update],
      constraints: {
        id: TokenAuthenticateMe::UUID_REGEX
      }
    )
  end
        ROUTE
      end

      def create_users_controller
        template 'users.rb', 'app/controllers/api/v1/users_controller.rb'

        # Inject /api/v1/users route into routes file
        route <<-ROUTE
namespace :api do
    namespace :v1 do
      resources :users
    end
  end
        ROUTE

        inject_into_class(
          Rails.root.join('app', 'controllers', 'api', 'v1', 'users_controller.rb'),
          UsersController) do
            "  skip_before_action :authenticate, only: [:create]\n"
        end

      end
    end
  end
end
