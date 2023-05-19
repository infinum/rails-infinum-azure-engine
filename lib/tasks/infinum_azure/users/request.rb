# frozen_string_literal: true

require 'uri'
require 'net/http'
require_relative 'response'

module InfinumAzure
  module Users
    class Request
      URL = InfinumAzure.users_auth_url

      def self.execute
        raise 'infinum_azure_users_auth_url secret required for this rake task' if URL.blank?

        uri = URI(URL)

        Response.new(Net::HTTP.get_response(uri))
      end
    end
  end
end
