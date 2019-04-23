$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'token_authenticate_me/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'token_authenticate_me'
  s.version     = TokenAuthenticateMe::VERSION
  s.authors     = ['Sam Clopton', 'Joe Weakley']
  s.email       = ["samsinite@gmail.com"]
  s.homepage    = 'https://github.com/wildland/token_authenticate_me'
  s.summary     = 'This gem adds simple token authentication to users.'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']
  s.test_files = Dir["test/**/*"]

  s.add_dependency 'rails', ['>= 4.1', '< 5']
  s.add_dependency 'api_me', '>= 0.6'
  s.add_dependency 'bcrypt', '~> 3.1.7'

  s.add_development_dependency 'pg'
end
