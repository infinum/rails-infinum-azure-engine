# frozen_string_literal: true

module InfinumAzure
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    respond_to :html

    delegate :resource_class, to: InfinumAzure
    delegate :resource_name, to: 'InfinumAzure.config'

    def current_resource
      method(:"current_#{resource_name.underscore}").call
    end
  end
end
