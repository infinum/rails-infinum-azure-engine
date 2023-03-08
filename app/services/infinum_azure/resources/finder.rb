# frozen_string_literal: true

module InfinumAzure
  module Resources
    class Finder
      def self.from_omniauth(auth)
        InfinumAzure.resource_class.find_by(provider: auth.provider, uid: auth.uid)
      end

      # this is a temporary method which won't be used in subsequent versions
      # the user data first has to be migrated (update provider to azure and uid from B2C)
      # in the meantime, we'll use a lowercased email as a unique identifier
      def self.from_omniauth_by_email(auth)
        InfinumAzure.resource_class.find_for_authentication(email: auth.email)
      end
    end
  end
end
