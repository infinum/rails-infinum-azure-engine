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
  setting :resource_attributes, default: [:uid, :email, :name, :first_name, :last_name,
                                          :avatar_url, :deactivated_at, :provider_groups], reader: true

  setting :user_migration_scope, default: -> { resource_class.where(provider: 'infinum_id') }, reader: true
  setting :user_migration_operation,
          default: -> (record, resource) {
            record.update_attribute(:provider, provider)
            record.update_attribute(:uid, resource['Uid'])
          },
          reader: true

  def self.provider
    to_s.underscore
  end

  def self.resource_class
    resource_name.constantize
  end

  def self.client_id
    dig_secret(:client_id)
  end

  def self.client_secret
    dig_secret(:client_secret)
  end

  def self.tenant
    dig_secret(:tenant)
  end

  def self.users_auth_url
    dig_secret(:users_auth_url)
  end

  def self.dig_secret(key)
    Rails.application.secrets.dig(:infinum_azure, key)
  end
end
