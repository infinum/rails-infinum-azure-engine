# frozen_string_literal: true

RSpec.describe InfinumAzure::Config do
  subject(:config) { described_class.new }

  describe 'attribute writers and readers' do
    it 'creates attribute writer methods for all keys' do
      expect { config.service_name = 'Example' }.to change(config, :service_name).from(nil).to('Example')
    end
  end

  describe 'attribute readers from Defaults' do
    it 'creates attribute methods that default to nil if not set' do
      config.service_name = 'Example'
      config.resource_name = 'User'

      expect(config.service_name).to eq('Example')
      expect(config.resource_name).to eq('User')
      expect(config.resource_attributes).to be_a(Array)
      expect(config.user_migration_scope).to be_a(Proc)
      expect(config.user_migration_operation).to be_a(Proc)
    end
  end
end
