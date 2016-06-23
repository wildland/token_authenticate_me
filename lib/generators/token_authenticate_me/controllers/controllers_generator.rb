module TokenAuthenticateMe
  module Generators
    class ControllersGenerator < ::Rails::Generators::NamedBase
      source_root File.expand_path('../templates', __FILE__)
      check_class_collision suffix: 'Controller'
    end
  end
end
