# frozen_string_literal: true

begin
  require 'factory_bot_rails'
rescue LoadError # rubocop:disable Lint/SuppressedException
end

module InfinumAzure
  class Engine < ::Rails::Engine
    if defined?(FactoryBotRails)
      config.factory_bot.definition_file_paths += [File.expand_path('../../spec/factories', __dir__)]
    end
  end
end
