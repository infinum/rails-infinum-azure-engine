# frozen_string_literal: true

module InfinumAzure
  class Config
    PROVIDER_INFINUM_ID = 'infinum_id'
    PROVIDER_INFINUM_AZURE = 'infinum_azure'
    UID = 'uid'
    DEFAULT_RESOURCE_ATTRIBUTES = [
      :uid, :email, :first_name, :last_name, :avatar_url, :deactivated_at, :provider_groups, :employee
    ].freeze

    attr_accessor :resource_name, :resource_attributes, :user_migration_scope, :user_migration_operation, :client_id,
                  :client_secret, :domain, :tenant, :users_auth_url

    def initialize
      self.resource_attributes = DEFAULT_RESOURCE_ATTRIBUTES
      self.user_migration_scope = -> { InfinumAzure.resource_class.where(provider: PROVIDER_INFINUM_ID) }
      self.user_migration_operation = ->(record, resource) {
        record.update_attribute(:provider, PROVIDER_INFINUM_AZURE)
        record.update_attribute(:uid, resource[UID])
      }
    end

    def validate!
      [:resource_name, :resource_attributes, :user_migration_scope, :user_migration_operation, :client_id,
       :client_secret, :domain, :tenant].each do |attribute|
        raise InfinumAzure::Error, "InfinumAzure attribute '@#{attribute}' not set" if public_send(attribute).blank?
      end
    end
  end
end
