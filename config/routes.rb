# frozen_string_literal: true

require 'sidekiq/web'

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      jsonapi_resources :agents, only: [:index, :show, :update, :destroy]
      jsonapi_resources :jobs, only: [:index, :create, :show, :update, :destroy]
      jsonapi_resources :media_items, only: [:index, :create, :show, :update, :destroy]
      jsonapi_resources :storage_backends, only: [:index, :create, :show, :update, :destroy]
      jsonapi_resources :tasks, only: [:index, :create, :show, :update, :destroy]

      namespace :exec do
        defaults format: :json do
          post 'agents/register'
          post 'media/import'
          get 'tasks/poll'
          post 'tasks/acquire/:id', to: 'tasks#acquire'
          post 'tasks/release/:id', to: 'tasks#release'
          post 'tasks/update/:id', to: 'tasks#update'
        end
      end
    end
  end

  mount Sidekiq::Web => '/sidekiq'
end
