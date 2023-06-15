# frozen_string_literal: true

require 'omniauth/infinum_azure'
require 'infinum_azure/version'
require 'infinum_azure/engine'
require 'infinum_azure/defaults'
require 'infinum_azure/config'
require 'devise'

module InfinumAzure
  Error = Class.new(StandardError)

  class << self
    def configure
      yield config if block_given?

      ensure_all_attributes_present!
    end

    def config
      @config ||= Config.new
    end

    def ensure_all_attributes_present!
      Defaults.all_attribute_names.each do |attribute|
        raise Error, "InfinumAzure attribute '@#{attribute}' not set" if config.public_send(attribute).blank?
      end
    end

    delegate(*Defaults.all_attribute_names, to: :config)

    def provider
      to_s.underscore
    end

    def resource_class
      resource_name.constantize
    end

    def client_id
      dig_secret(:client_id)
    end

    def client_secret
      dig_secret(:client_secret)
    end

    def tenant
      dig_secret(:tenant)
    end

    def users_auth_url
      dig_secret(:users_auth_url)
    end

    def dig_secret(key)
      Rails.application.secrets.dig(:infinum_azure, key)
    end
  end
end
