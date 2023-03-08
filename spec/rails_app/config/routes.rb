# frozen_string_literal: true

Rails.application.routes.draw do
  mount InfinumAzure::Engine, at: '/'

  root to: 'home#index'
end
