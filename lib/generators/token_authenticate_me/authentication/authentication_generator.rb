module TokenAuthenticateMe
  module Generators
    class AuthenticationGenerator < ::Rails::Generators::NamedBase
      include Rails::Generators::Migration

      source_root File.expand_path('../templates', __FILE__)
      check_class_collision suffix: ''

      def self.next_migration_number(dirname)
        next_migration_number = current_migration_number(dirname) + 1
        ActiveRecord::Migration.next_migration_number(next_migration_number)
      end

      def create_authentication_model_file
        template 'model.rb', File.join('app/models', "#{singular_name}.rb")
      end

      def create_authentication_migration_file
        migration_template 'migration.rb', File.join('db/migrations', "#{file_name}.rb")
      end
    end
  end
end
