# frozen_string_literal: true

RSpec.describe InfinumAzure::Resources::Finder do
  describe '.from_omniauth' do
    it 'returns user if user is found' do
      user = create(:user, provider: 'infinum_azure', uid: 1)

      auth = instance_double('auth', provider: 'infinum_azure', uid: 1)
      response = described_class.from_omniauth(auth)

      expect(response).to eq(user)
    end

    it 'returns nil if user is not found' do
      auth = instance_double('auth', provider: 'infinum_azure', uid: 1)
      response = described_class.from_omniauth(auth)

      expect(response).to be_nil
    end
  end

  describe '.from_omniauth_by_email' do
    it 'returns user if user is found' do
      user = create(:user, email: 'john.doe@example.com')

      response = described_class.from_omniauth_by_email(user.email.upcase)

      expect(response).to eq(user)
    end

    it 'returns nil if user is not found' do
      email = 'example@email.com'

      response = described_class.from_omniauth_by_email(email)

      expect(response).to be_nil
    end
  end
end
