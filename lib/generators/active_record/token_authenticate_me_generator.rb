require 'rails/generators/active_record'
require 'generators/token_authenticate_me/orm_helpers'

module ActiveRecord
  module Generators
    class TokenAuthenticateMeGenerator < ActiveRecord::Generators::Base
      argument :attributes, type: :array, default: [], banner: "field:type field:type"

      include TokenAuthenticateMe::Generators::OrmHelpers
      source_root File.expand_path("../templates", __FILE__)

      def copy_devise_migration
        if (behavior == :invoke && model_exists?) || (behavior == :revoke && migration_exists?(table_name))
          migration_template "migration_existing.rb", "db/migrate/add_token_authenticate_me_to_#{table_name}.rb"
        else
          migration_template "migration.rb", "db/migrate/token_authenticate_me_create_#{table_name}.rb"
        end
      end

      def generate_model
        invoke "active_record:model", [name], migration: false unless model_exists? && behavior == :invoke
      end

      def inject_token_authenticate_me_content
        content = model_contents

        class_path = if namespaced?
          class_name.to_s.split("::")
        else
          [class_name]
        end

        indent_depth = class_path.size - 1
        content = content.split("\n").map { |line| "  " * indent_depth + line } .join("\n") << "\n"

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
    end
  end
end
