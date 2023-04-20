# frozen_string_literal: true

require 'simplecov'
SimpleCov.start 'rails'
ENV['RAILS_ENV'] = 'test'

$LOAD_PATH.unshift File.dirname(__FILE__)
require 'pry'
require 'pry-rails'
require 'pry-byebug'
require 'rails_app/config/environment'
require 'rspec/rails'
require 'factory_bot_rails'
require 'faker'
require 'webmock/rspec'

Dir['./spec/support/**/*.rb'].sort.each { |f| require f }

ActiveRecord::Migrator.migrations_paths =
  [File.expand_path('../spec/rails_app/db/migrate', __dir__)]
ActiveRecord::Migration.maintain_test_schema!
OmniAuth.config.test_mode = true
ActiveJob::Base.queue_adapter = :test

InfinumAzure.config.service_name = 'InfinumAzure engine'
Rails.configuration.host_url = 'http://localhost:3000'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.include Devise::Test::IntegrationHelpers, type: :request
  config.include FactoryBot::Syntax::Methods
  config.include TestHelpers::HttpRequest, type: :request
  config.include TestHelpers::JsonResponse, type: :request
end
