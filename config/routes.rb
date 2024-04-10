Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  resources :games do
    member do
      post 'next_player'
      post 'next_dare'
    end
  end

  resources :players

  root 'games#show'
end
