# frozen_string_literal: true

Rails.application.routes.draw do
  get 'home/index'
  devise_for :users
  get "up" => "rails/health#show", as: :rails_health_check

  resources :games do
    member do
      post 'next_player'
      post 'next_dare'
      post 'restart'
    end
  end

  resources :players

  resources :dares

  root 'home#index'
end
