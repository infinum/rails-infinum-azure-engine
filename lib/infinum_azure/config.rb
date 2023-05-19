# frozen_string_literal: true

module InfinumAzure
  class Config
    Defaults.all_attributes.each do |attr, value|
      attr_writer attr

      define_method(attr) do
        instance_variable_set("@#{attr}", instance_variable_get("@#{attr}") || value)
      end
    end
  end
end
