# frozen_string_literal: true

require 'omniauth/infinum_azure'
require 'infinum_azure/version'
require 'infinum_azure/engine'
require 'infinum_azure/config'
require 'devise'

module InfinumAzure
  Error = Class.new(StandardError)

  class << self
    def configure
      yield config if block_given?

    end

    def config
      @config ||= Config.new
    end

    def provider
      to_s.underscore
    end

    def resource_class
    end
  end
end
