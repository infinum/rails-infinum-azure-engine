# frozen_string_literal: true

module InfinumAzure
  module Users
    class Response
      attr_reader :raw_response

      def initialize(raw_response)
        @raw_response = raw_response
      end

      def success?
        raw_response.is_a?(Net::HTTPSuccess)
      end

      def body
        @body ||= success? ? success_json['Value'] : error_json
      end

      private

      def success_json
        JSON.parse(raw_response.body)
      end

      def error_json
        {
          error: {
            status: raw_response.code.to_i,
            details: raw_response.body
          }
        }
      end
    end
  end
end
