# frozen_string_literal: true

RSpec.describe InfinumAzure do
  it 'has a version number' do
    expect(InfinumAzure::VERSION).not_to be_nil
  end

  describe '.configure' do
    it 'sets values to config attributes and uses default values when config attribute not set' do
      described_class.configure do |config|
        config.service_name = 'Example'
        config.resource_name = 'User'
        config.user_migration_operation = -> { 'from_block' }
      end

      expect(described_class.service_name).to eq('Example')
      expect(described_class.resource_name).to eq('User')
      expect(described_class.resource_attributes).to be_a(Array)
      expect(described_class.user_migration_scope.call).to be_a(ActiveRecord::Relation)
      expect(described_class.user_migration_operation.call).to eq('from_block')
    end

    it 'raises error if attribute not set' do
      expect do
        described_class.configure do |config|
          config.service_name = nil
          config.resource_name = 'User'
        end
      end.to raise_error(described_class::Error, "InfinumAzure attribute '@service_name' not set")
    end
  end
end
