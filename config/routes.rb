# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      jsonapi_resources :groups, only: [:index, :create, :show, :update, :destroy]
    end
  end

  scope :auth, defaults: { format: :json } do
    devise_for :users, skip: :all
    devise_scope :user do
      post 'signup' => 'users/registrations#create'
    end
    post 'signin' => 'authentication#authenticate_user'
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
