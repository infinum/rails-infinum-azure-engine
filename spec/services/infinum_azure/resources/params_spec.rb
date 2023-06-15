# frozen_string_literal: true

RSpec.describe InfinumAzure::Resources::Params do
  describe '.normalize' do
    subject(:normalized_hash) { described_class.normalize(params) }

    let(:propagating_params) do
      {
        uid: '1',
        email: 'email',
        first_name: 'first_name',
        last_name: 'last_name',
        avatar_url: 'avatar_url'
      }
    end

    describe 'attributes to propagate' do
      let(:params) { propagating_params }

      it 'just propagates the attributes marked as :propagate' do
        expect(normalized_hash).to eq(params.merge(deactivated_at: nil, employee: nil))
      end
    end

    describe 'deactivated_at' do
      let(:params) { propagating_params.merge(deactivated: deactivated) }

      context 'when deactivated is set to true' do
        let(:deactivated) { true }

        it 'returns deactivated_at set to current time' do
          freeze_time do
            expect(normalized_hash[:deactivated_at]).to eq(Time.zone.now)
          end
        end
      end

      context 'when deactivated is set to false' do
        let(:deactivated) { false }

        it 'returns deactivated_at set to nil' do
          expect(normalized_hash[:deactivated_at]).to be_nil
        end
      end
    end

    describe 'employee' do
      let(:params) { propagating_params.merge(groups: groups) }

      context 'when groups contains "employees" substring' do
        let(:groups) { 'employees' }

        it 'returns employee set to true' do
          expect(normalized_hash[:employee]).to be_truthy
        end
      end

      context 'when groups has no "employees" substring' do
        let(:groups) { 'contractors' }

        it 'returns employee set to false' do
          expect(normalized_hash[:employee]).to be_falsey
        end
      end
    end
  end
end
