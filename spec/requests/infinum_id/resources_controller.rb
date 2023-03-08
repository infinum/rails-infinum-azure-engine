require 'spec_helper'

RSpec.describe InfinumAzure::ResourcesController do
  describe '#destroy' do
    it 'logouts current user and redirects to root_path' do
      user = create(:user)
      sign_in user

      get '/logout'

      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to(:root)
    end
  end
end
