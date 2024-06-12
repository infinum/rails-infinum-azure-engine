# frozen_string_literal: true

RSpec.describe InfinumAzure do
  it 'has a version number' do
    expect(InfinumAzure::VERSION).not_to be_nil
  end

  describe '.configure' do
    it 'yields config' do # rubocop:disable RSpec/ExampleLength, RSpec/MultipleExpectations
      described_class.configure do |config|
        config.resource_name = 'User'
        config.user_migration_operation = -> { 'from_block' }
        config.client_id = 'client-id'
        config.client_secret = 'client-secret'
        config.domain = 'https://login.b2c.com'
        config.tenant = 'tenant'
        config.users_auth_url = 'https://example.com'
      end

      expect(described_class.config.resource_name).to eq('User')
      expect(described_class.config.resource_attributes).to be_a(Array)
      expect(described_class.config.user_migration_scope.call).to be_a(ActiveRecord::Relation)
      expect(described_class.config.user_migration_operation.call).to eq('from_block')
      expect(described_class.config.client_id).to eq('client-id')
      expect(described_class.config.client_secret).to eq('client-secret')
      expect(described_class.config.domain).to eq('https://login.b2c.com')
      expect(described_class.config.tenant).to eq('tenant')
      expect(described_class.config.users_auth_url).to eq('https://example.com')
    end

    it 'raises error if attribute not set' do
      expect do
        described_class.configure do |config|
          config.resource_name = 'User'
          config.client_id = 'client-id'
          config.domain = 'https://eample.com'
          config.tenant = 'tenant'
          config.client_secret = nil
        end
      end.to raise_error(InfinumAzure::Error, "InfinumAzure attribute '@client_secret' not set")
    end
  end
end
