# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "token_authenticate_me/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'token_authenticate_me'
  s.version     = TokenAuthenticateMe::VERSION
  s.authors     = ['Sam Clopton', 'Joe Weakley']
  s.email       = ['samsinite@gmail.com']
  s.homepage    = 'https://github.com/inigo-llc/token_authenticate_me'
  s.summary     = 'This gem adds simple token authentication to users.'
  s.license     = 'MIT'

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["{spec,test}/**/*"]

  s.add_runtime_dependency     'bcrypt', '~> 3.1.9'
  s.add_dependency "rails", "~> 4.2.6"

  s.add_development_dependency 'rubocop', '>= 0.27.0'
  s.add_development_dependency 'combustion', '~> 0.5.2'
  s.add_development_dependency 'rack-test'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'api_me'
  s.add_development_dependency "sqlite3"
end
