# frozen_string_literal: true

Rails.application.routes.draw do
  get '/users/auth/infinum_azure/logout', to: 'infinum_azure/resources#passthru', as: :infinum_azure_logout
  get '/users/auth/logout', to: 'infinum_azure/resources#destroy', as: :logout

  devise_for InfinumAzure.resource_name.pluralize.underscore, controllers: {
    omniauth_callbacks: 'infinum_azure/resources/omniauth_callbacks'
  }

  namespace :infinum_azure do
    namespace :api do
      scope '/webhooks', controller: :webhooks do
        post :upsert_resource_callback
      end
    end
  end
end
