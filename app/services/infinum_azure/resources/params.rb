# frozen_string_literal: true

module InfinumAzure
  module Resources
    class Params
      NORMALIZATIONS = {
        uid: :propagate,
        email: :propagate,
        first_name: :propagate,
        last_name: :propagate,
        avatar_url: :propagate,
        deactivated_at: {
          procedure: ->(value) { [false, nil].include?(value) ? nil : Time.zone.now },
          target_name: :deactivated
        },
        employee: {
          procedure: ->(value) { value&.include?('employees') },
          target_name: :groups
        },
        groups: :propagate
      }.freeze

      def self.normalize(payload)
        new(payload).as_json
      end

      def initialize(params = {})
        NORMALIZATIONS.each do |attribute, operation|
          value = if operation == :propagate
                    params[attribute]
                  elsif operation.is_a?(Hash)
                    operation[:procedure].call(params[operation[:target_name]])
                  else
                    raise 'unsupported normalization'
                  end

          instance_variable_set(:"@#{attribute}", value)
        end
      end

      def as_json
        NORMALIZATIONS.keys.index_with do |key|
          instance_variable_get(:"@#{key}")
        end
      end

      private

      attr_reader(*NORMALIZATIONS.keys)
    end
  end
end
