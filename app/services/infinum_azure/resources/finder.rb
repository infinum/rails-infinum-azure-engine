# frozen_string_literal: true

module InfinumAzure
  module Resources
    class Finder
      def self.from_omniauth(auth)
        InfinumAzure.resource_class.find_by(provider: auth.provider, uid: auth.uid)
      end
    end
  end
end
