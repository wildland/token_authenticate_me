module TokenAuthenticateMe
  module Generators
    class ModelsGenerator < ::Rails::Generators::Base
      include Rails::Generators::Migration

      source_root File.expand_path('../templates', __FILE__)
    end
  end
end
