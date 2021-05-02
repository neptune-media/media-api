# frozen_string_literal: true

Rails.application.routes.draw do
  scope :auth, defaults: { format: :json } do
    devise_for :users, skip: :all
    devise_scope :user do
      post 'signup' => 'devise/registrations#create'
    end
    post 'signin' => 'authentication#authenticate_user'
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
