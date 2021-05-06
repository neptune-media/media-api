# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      jsonapi_resources :agents, only: [:index, :create, :show, :update, :destroy]
      jsonapi_resources :jobs, only: [:index, :create, :show, :update, :destroy]
      jsonapi_resources :storage_backends, only: [:index, :create, :show, :update, :destroy]
      jsonapi_resources :tasks, only: [:index, :create, :show, :update, :destroy]
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
