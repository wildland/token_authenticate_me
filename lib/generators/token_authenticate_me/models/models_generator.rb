module TokenAuthenticateMe
  module Generators
    class ModelsGenerator < ::Rails::Generators::NamedBase
      include Rails::Generators::Migration

      source_root File.expand_path('../templates', __FILE__)
      check_class_collision suffix: ''

      def self.next_migration_number(dirname)
        next_migration_number = current_migration_number(dirname) + 1
        ActiveRecord::Migration.next_migration_number(next_migration_number)
      end

      def create_authentication_model_file
        template 'authentication_model.rb', File.join('app/models', "user.rb")
      end

      def create_authentication_migration_file
        # When the switch is made to allow resource names to be specified, could use something like:
        #    migration_file_name = "#{self.next_migration_number}_#{plural_name}.rb"
        #    migration_template 'authentication_migration.rb', File.join('db/migrations', migration_file_name)
        migration_template 'authentication_migration.rb', File.join('db/migrations', "#{self.next_migration_number}_users.rb")
      end

      def create_session_model_file
        template 'session_model.rb', File.join('app/models', "session.rb")
      end

      def create_session_migration_file
        # When the switch is made to allow resource names to be specified, could use something like:
        #    migration_file_name = "#{self.next_migration_number}_#{singular_name}_sessions.rb"
        #    migration_template 'authentication_migration.rb', File.join('db/migrations', migration_file_name)
        migration_template 'session_migration.rb', File.join('db/migrations', "#{self.next_migration_number}_sessions.rb")
      end
    end
  end
end
