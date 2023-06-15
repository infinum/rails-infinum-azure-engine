# frozen_string_literal: true

RSpec.describe InfinumAzure do
  it 'has a version number' do
    expect(InfinumAzure::VERSION).not_to be nil
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

  describe 'delegated methods' do
    before do
      described_class.configure do |config|
        config.service_name = 'Example'
        config.resource_name = 'User'
      end
    end

    describe '#service_name' do
      it 'returns correct value' do
        expect(described_class.service_name).to eq('Example')
      end
    end

    describe '#resource_name' do
      it 'returns correct value' do
        expect(described_class.resource_name).to eq('User')
      end
    end

    describe '#resource_attributes' do
      it 'returns array' do
        expect(described_class.resource_attributes).to be_a(Array)
      end
    end

    describe '#user_migration_scope' do
      it 'returns proc' do
        expect(described_class.user_migration_scope).to be_a(Proc)
      end
    end

    describe '#user_migration_operation' do
      it 'returns proc' do
        expect(described_class.user_migration_operation).to be_a(Proc)
      end
    end

    describe '.provider' do
      it 'returns "infinum_azure"' do
        expect(described_class.provider).to eq('infinum_azure')
      end
    end

    describe '.resource_class' do
      it 'returns constantized resource_name' do
        expect(described_class.resource_class).to eq(User)
      end
    end

    describe '.client_id' do
      it 'returns value from secrets' do
        expect(described_class.client_id).to eq('vault_client_id')
      end
    end

    describe '.client_secret' do
      it 'returns value from secrets' do
        expect(described_class.client_secret).to eq('vault_client_secret')
      end
    end

    describe '.tenant' do
      it 'returns value from secrets' do
        expect(described_class.tenant).to eq('infinumtest')
      end
    end

    describe '.users_auth_url' do
      it 'returns value from secrets' do
        expect(described_class.users_auth_url).to eq('http://example_api_url_with_users.com')
      end
    end
  end
end
