# frozen_string_literal: true

module InfinumAzure
  module Defaults
    REQUIRED = {
      service_name: nil,
      resource_name: nil
    }.freeze
    OPTIONAL = {
      resource_attributes: [
        :uid, :email, :first_name, :last_name, :avatar_url, :deactivated_at, :provider_groups, :employee
      ],
      user_migration_scope: -> { InfinumAzure.resource_class.where(provider: 'infinum_id') },
      user_migration_operation: ->(record, resource) {
        record.update_attribute(:provider, provider)
        record.update_attribute(:uid, resource['uid'])
      }
    }.freeze

    def self.all_attribute_names
      REQUIRED.keys + OPTIONAL.keys
    end

    def self.all_attributes
      REQUIRED.merge(OPTIONAL)
    end
  end
end
