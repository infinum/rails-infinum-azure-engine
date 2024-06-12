# frozen_string_literal: true

module InfinumAzure
  class Config
    PROVIDER_INFINUM_ID = 'infinum_id'
    PROVIDER_INFINUM_AZURE = 'infinum_azure'
    UID = 'uid'
    DEFAULT_RESOURCE_ATTRIBUTES = [
      :uid, :email, :first_name, :last_name, :avatar_url, :deactivated_at, :provider_groups, :employee
    ].freeze

    attr_accessor :resource_name
    attr_accessor :resource_attributes
    attr_accessor :user_migration_scope
    attr_accessor :user_migration_operation
    attr_accessor :client_id
    attr_accessor :client_secret
    attr_accessor :domain
    attr_accessor :tenant
    attr_accessor :users_auth_url

    def initialize
      self.resource_attributes = DEFAULT_RESOURCE_ATTRIBUTES
      self.user_migration_scope = -> { InfinumAzure.resource_class.where(provider: PROVIDER_INFINUM_ID) }
      self.user_migration_operation = lambda { |record, resource|
        record.update_columns( # rubocop:disable Rails/SkipsModelValidations
          provider: PROVIDER_INFINUM_AZURE,
          uid: resource[UID]
        )
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
