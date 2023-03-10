# frozen_string_literal: true

module InfinumAzure
  module Api
    class BaseController < ActionController::Base
      protect_from_forgery with: :null_session
      respond_to :json

      delegate :resource_name, :resource_class, to: InfinumAzure
    end
  end
end
