# frozen_string_literal: true

module InfinumAzure
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    respond_to :html

    delegate :resource_name, :resource_class, to: InfinumAzure

    def current_resource
      method("current_#{resource_name.underscore}").call
    end
  end
end
