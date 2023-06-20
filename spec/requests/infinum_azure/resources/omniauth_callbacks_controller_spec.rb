RSpec.describe InfinumAzure::Resources::OmniauthCallbacksController do
  describe '#infinum_azure' do
    let(:user) { create(:user) }

    it 'signs in and redirects user if user was found' do
      allow(InfinumAzure::Resources::Finder).to receive(:from_omniauth).and_return(user)

      get '/users/auth/infinum_azure/callback'

      expect(response).to have_http_status(:redirect)
      expect(user.remember_created_at).to be_present
    end

    it 'redirects to root path if user is not found' do
      allow(InfinumAzure::Resources::Finder).to receive(:from_omniauth).and_return(nil)

      get '/users/auth/infinum_azure/callback'

      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to(:root)
    end
  end
end
