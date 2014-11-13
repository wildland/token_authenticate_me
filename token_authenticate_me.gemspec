# -*- encoding: utf-8 -*-

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'token_authenticate_me/version'

Gem::Specification.new do |s|
  s.name        = 'token_authenticate_me'
  s.version     = TokenAuthenticateMe::VERSION
  s.authors     = ['Sam Clopton', 'Joe Weakley']
  s.email       = ['samsinite@gmail.com']
  s.homepage    = 'https://github.com/inigo-llc/token_authenticate_me'
  s.summary     = 'This gem adds simple token authentication to users.'
  s.license     = 'MIT'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {spec}/*`.split("\n")
  s.require_paths = ['lib']

  s.add_runtime_dependency     'activerecord', '>= 3.2.0'

  s.add_development_dependency 'rubocop', '>= 0.27.0'
end
