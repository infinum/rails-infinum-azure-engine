RSpec.describe InfinumAzure::Api::WebhooksController do
  describe '#upsert_resource_callback' do
    let(:user_params) { attributes_for(:user) }

    before do
      allow(InfinumAzure::AfterUpsertResource).to receive(:call).and_return(true)
    end

    it 'updates user if user exists' do
      user = create(:user)

      post '/infinum_azure/api/webhooks/upsert_resource_callback',
           params: { user: user_params.merge(email: user.email) }.to_json,
           headers: default_headers

      expect(response).to have_http_status(:success)
      expect(json_body).to include(user: 'updated')
      expect(user.reload).to have_attributes(
        first_name: user_params[:first_name],
        last_name: user_params[:last_name],
        email: user.email,
        provider: 'infinum_azure'
      )
      expect(InfinumAzure::AfterUpsertResource).to have_received(:call).once
    end

    it 'creates user if user does not exist' do
      post '/infinum_azure/api/webhooks/upsert_resource_callback',
           params: { user: user_params }.to_json,
           headers: default_headers

      expect(response).to have_http_status(:success)
      expect(json_body).to include(user: 'created')
      expect(User.first).to have_attributes(
        first_name: user_params[:first_name],
        last_name: user_params[:last_name],
        email: user_params[:email],
        provider: 'infinum_azure'
      )
      expect(InfinumAzure::AfterUpsertResource).to have_received(:call).once
    end
  end
end
