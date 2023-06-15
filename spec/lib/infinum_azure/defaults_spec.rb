# frozen_string_literal: true

RSpec.describe InfinumAzure::Defaults do
  before do
    stub_const("#{described_class}::REQUIRED", { key1: anything, key2: anything })
    stub_const("#{described_class}::OPTIONAL", { key3: anything, key4: anything })
  end

  describe '.all_attribute_names' do
    it 'returns all keys from required and optional hash' do
      expect(described_class.all_attribute_names).to eq([:key1, :key2, :key3, :key4])
    end
  end

  describe '.all_attributes' do
    it 'returns all key value pairs from required and optional hash' do
      expect(described_class.all_attributes).to eq({ key1: anything, key2: anything, key3: anything, key4: anything })
    end
  end
end
