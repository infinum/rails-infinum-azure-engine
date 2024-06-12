# frozen_string_literal: true

module InfinumAzure
  class Engine < ::Rails::Engine
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
