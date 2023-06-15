RSpec.describe InfinumAzure::Api::WebhooksController do
  describe '#upsert_resource_callback' do
    let(:user_params) { attributes_for(:user).merge(azure_params) }
    let(:azure_params) do
      {
        "avatar_url": 'https://avatar_url.com',
        "deactivated": false,
        "groups": 'employees'
      }
    end

    before do
      allow(InfinumAzure::AfterUpsertResource).to receive(:call).and_return(true)
    end

    it 'updates user if user exists' do
      freeze_time do
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
          provider: 'infinum_azure',
          avatar_url: azure_params[:avatar_url],
          deactivated_at: nil,
          employee: true
        )
        expect(InfinumAzure::AfterUpsertResource).to have_received(:call).once
      end
    end

    it 'creates user if user does not exist' do
      expected_params = {
        uid: user_params[:uid],
        email: user_params[:email],
        first_name: user_params[:first_name],
        last_name: user_params[:last_name],
        avatar_url: azure_params[:avatar_url],
        deactivated_at: nil,
        employee: true
      }

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
      expect(InfinumAzure::AfterUpsertResource)
        .to have_received(:call).with(User.first, expected_params).once
    end
  end
end
