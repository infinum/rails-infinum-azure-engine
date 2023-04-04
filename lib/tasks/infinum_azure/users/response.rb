# frozen_string_literal: true

module InfinumAzure
  module Users
    class Response
      attr_reader :raw_response, :status

      def initialize(raw_response)
        @raw_response = raw_response
        @status = raw_response.status
      end

      def success?
        status.ok?
      end

      def body
        @body ||= success? ? success_json['Value'] : error_json
      end

      private

      def success_json
        JSON.parse(raw_response.body.to_s)
      end

      def error_json
        {
          error: {
            status: raw_response.status.to_i,
            details: raw_response.body.to_s
          }
        }
      end
    end
  end
end
