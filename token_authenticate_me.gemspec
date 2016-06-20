$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "token_authenticate_me/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "token_authenticate_me"
  s.version     = TokenAuthenticateMe::VERSION
  s.authors     = ["Sam Clopton"]
  s.email       = ["samsinite@gmail.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of TokenAuthenticateMe."
  s.description = "TODO: Description of TokenAuthenticateMe."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.6"

  s.add_development_dependency "sqlite3"
end
