# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      jsonapi_resources :agents, only: [:index, :create, :show, :update, :destroy]
      jsonapi_resources :jobs, only: [:index, :create, :show, :update, :destroy]
      jsonapi_resources :storage_backends, only: [:index, :create, :show, :update, :destroy]
      jsonapi_resources :tasks, only: [:index, :create, :show, :update, :destroy]

      namespace :exec do
        defaults format: :json do
          post 'agents/register'
          get 'tasks/poll'
          post 'tasks/acquire/:id', to: 'tasks#acquire'
          post 'tasks/release/:id', to: 'tasks#release'
        end
      end
    end
  end
end
