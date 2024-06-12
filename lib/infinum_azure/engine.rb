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

    initializer 'infinum_azure.devise_omniauth', before: 'devise.omniauth' do
      Devise.setup do |config|
        # ==> OmniAuth
        config.omniauth :infinum_azure,
                        InfinumAzure.config.client_id,
                        InfinumAzure.config.client_secret,
                        client_options: {
                          domain: InfinumAzure.config.domain,
                          tenant: InfinumAzure.config.tenant
                        }
      end
    end
  end
end
