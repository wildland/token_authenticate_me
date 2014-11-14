# TODO: Add check for existence, and handle

module ActiveRecord
  module Generators
    class AuthenticationModelGenerator < ::Rails::Generators::NamedBase
      source_root File.expand_path('../templates', __FILE__)
      check_class_collision suffix: ''

      # argument :attributes, type: :array, default: [], banner: 'field field'

      # class_option :parent, type: :string, desc: 'The parent class for the generated controller'

      def create_auhentication_model_file
        template 'model.rb', File.join('app/models', "#{singular_name}.rb")
      end
    end
  end
end
