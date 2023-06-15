# frozen_string_literal: true

module InfinumAzure
  module Users
    class Migration
      delegate :user_migration_scope, :user_migration_operation, to: InfinumAzure

      def self.perform(response = {})
        new(response).perform
      end

      attr_reader :response

      def initialize(response)
        @response = response
        @users_updated_count = 0
        @emails_not_found = []
      end

      def perform
        user_migration_scope.call.each do |record|
          resource = response.find { |object| object['email'] == record.email }
          emails_not_found.push(record.email) && next if resource.nil?

          user_migration_operation.call(record, resource)
          self.users_updated_count += 1
        end

        self
      end

      def results
        <<~HEREDOC
          Count of updated resources: #{users_updated_count}
          Emails not found on Infinum Azure AD B2C: #{emails_not_found.size}
          Emails:
          #{emails_not_found.join("\n")}
        HEREDOC
      end

      private

      attr_accessor :users_updated_count, :emails_not_found
    end
  end
end
