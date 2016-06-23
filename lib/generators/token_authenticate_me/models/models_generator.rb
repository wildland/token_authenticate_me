module TokenAuthenticateMe
  module Generators
    class ModelsGenerator < ::Rails::Generators::NamedBase
      include Rails::Generators::Migration

      source_root File.expand_path('../templates', __FILE__)
      check_class_collision suffix: ''
    end
  end
end
