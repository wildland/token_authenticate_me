require 'rubygems'
require 'bundler/setup'
require 'combustion'

Bundler.require :default, :development

Combustion.initialize! :active_record, :action_controller, :action_mailer, :action_view

require 'rspec/rails'
require 'rack/test'

# Load fixture helpers for testing
Dir[File.join(File.dirname(__FILE__), 'internal', 'db', "fixtures", "**", '*.rb')].each { |file| require file }

module ApiHelper
  include Rack::Test::Methods

  def app
    Rails.application
  end
end

RSpec.configure do |config|
  config.use_transactional_fixtures = true
  config.mock_with :rspec

  config.before do
    ActionMailer::Base.delivery_method = :test
    ActionMailer::Base.default_options = {
      from: 'no-reply@test.com'
    }
  end

  config.include ApiHelper
  config.include Fixtures::Users
end
