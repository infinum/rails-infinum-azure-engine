# frozen_string_literal: true

Rails.application.routes.draw do
  get '/logout', to: 'infinum_azure/resources#destroy'

  devise_for InfinumAzure.resource_name.pluralize.underscore, controllers: {
    omniauth_callbacks: 'infinum_azure/resources/omniauth_callbacks'
  }
end
