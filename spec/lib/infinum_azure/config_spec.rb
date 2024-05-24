# frozen_string_literal: true

RSpec.describe InfinumAzure::Config do
  subject(:config) { described_class.new }

  describe 'default values' do
    it 'initializes #resource_attributes' do
      expect(config.resource_attributes).not_to be_empty
    end

    it 'initializes #user_migration_scope' do
      expect(config.user_migration_scope).to be_a(Proc)
    end

    it 'initializes #user_migration_operation' do
      expect(config.user_migration_operation).to be_a(Proc)
      expect(config.user_migration_operation.arity).to eq(2)
    end
  end

  describe '#validate!' do
    it 'raises error if attribute not set' do
      config.resource_name = 'User'
      config.client_id = 'client-id'
      config.domain = 'https://eample.com'
      config.tenant = 'tenant'
      config.client_secret = nil

      expect do
        config.validate!
      end.to raise_error(InfinumAzure::Error, "InfinumAzure attribute '@client_secret' not set")
    end
  end
end
