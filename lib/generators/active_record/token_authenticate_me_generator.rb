require 'rails/generators/active_record'
require 'generators/token_authenticate_me/orm_helpers'

module ActiveRecord
  module Generators
    class TokenAuthenticateMeGenerator < ActiveRecord::Generators::Base
      argument :attributes, type: :array, default: [], banner: 'field:type field:type'

      include TokenAuthenticateMe::Generators::OrmHelpers
      source_root File.expand_path('../templates', __FILE__)

      def copy_devise_migration
        if invoked_and_exists? || revoked_and_exists?
          existing_migration_template
        else
          new_migration_template
        end
      end

      def generate_model
        invoke 'active_record:model', [name], migration: false unless invoked_and_exists?
      end

      def inject_token_authenticate_me_content # rubocop:disable Metrics/AbcSize
        content = model_contents

        class_path = if namespaced?
                       class_name.to_s.split('::')
                     else
                       [class_name]
                     end

        indent_depth = class_path.size - 1
        content = content.split("\n").map { |line| '  ' * indent_depth + line } .join("\n") << "\n"

        inject_into_class(model_path, class_path.last, content) if model_exists?
      end

      def migration_data
        <<RUBY
      t.string :username,  null: false
      t.string :email, null: false
      t.string :password_digest, null: false
      t.string :reset_token
      t.datetime :reset_token_exp
RUBY
      end

      private

      def existing_migration_template
        migration_template(
          'migration_existing.rb',
          "db/migrate/add_token_authenticate_me_to_#{table_name}.rb"
        )
      end

      def new_migration_template
        migration_template(
          'migration.rb',
          "db/migrate/token_authenticate_me_create_#{table_name}.rb"
        )
      end

      def invoked_and_exists?
        model_exists? && behavior == :invoke
      end

      def revoked_and_exists?
        behavior == :revoke && migration_exists?(table_name)
      end
    end
  end
end
