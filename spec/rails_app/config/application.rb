# frozen_string_literal: true

require File.expand_path('boot', __dir__)

require 'rails/all'

Bundler.require(*Rails.groups)

module RailsApp
  class Application < Rails::Application
    config.root = File.expand_path('..', __dir__)
    config.i18n.enforce_available_locales = true
    config.active_record.legacy_connection_handling = false

    InfinumAzure.config.service_name = 'Specs'
    InfinumAzure.config.resource_name = 'User'
    InfinumAzure.config.resource_attributes = [
      :uid, :email, :first_name, :last_name, :avatar_url, :deactivated_at, :provider_groups, :employee
    ]
  end
end
