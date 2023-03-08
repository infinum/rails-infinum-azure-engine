# frozen_string_literal: true
require 'omniauth/infinum_azure'
require 'infinum_azure/version'
require 'infinum_azure/engine'
require 'dry-configurable'
require 'devise'
require 'http'

module InfinumAzure
  extend Dry::Configurable

  setting :service_name, reader: true
  setting :resource_name, default: 'User', reader: true

  setting :resource_attributes, default: [:uid, :email, :name], reader: true

  def self.resource_class
    resource_name.constantize
  end

  def self.client_id
    dig_secret(:client_id)
  end

  def self.client_secret
    dig_secret(:client_secret)
  end

  def self.name
    dig_secret(:name)
  end

  def self.tenant
    dig_secret(:tenant)
  end

  def self.policy
    dig_secret(:policy)
  end

  def self.scope
    dig_secret(:scope)
  end

  def self.dig_secret(key)
    if Rails::VERSION::MAJOR >= 5
      Rails.application.secrets.dig(:infinum_azure, key)
    else
      Rails.application.secrets.dig(:infinum_azure, key.to_s)
    end
  end
end
