# frozen_string_literal: true

module InfinumAzure
  module Users
    class Migration
      def self.perform(data = {})
        new(data).perform
      end

      attr_reader :data

      def initialize(data)
        @data = data
        @users_updated_count = 0
        @emails_not_found = []
      end

      def perform
        InfinumAzure.resource_class.where(provider: 'infinum_id').each(&update_resource)

        self
      end

      def results
        <<~HEREDOC
          Users updated count: #{users_updated_count}
          Emails not found on Infinum Azure AD B2C: #{emails_not_found}
        HEREDOC
      end

      private

      def update_resource
        lambda do |resource|
          matching_user = data.find { |user| user['PrimaryEmail'] == resource.email }

          if matching_user.present?
            resource.update_attribute(:provider, 'infinum_azure')
            resource.update_attribute(:uid, matching_user['Id'])
            self.users_updated_count += 1
          else
            emails_not_found.push(resource.email)
          end
        end
      end

      attr_accessor :users_updated_count, :emails_not_found
    end
  end
end
