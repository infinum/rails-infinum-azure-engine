# frozen_string_literal: true

module InfinumAzure
  module Api
    class BaseController < ApplicationController
      protect_from_forgery with: :null_session
      respond_to :json

      delegate :resource_name, to: 'InfinumAzure.config'
      delegate :resource_class, to: InfinumAzure
    end
  end
end
