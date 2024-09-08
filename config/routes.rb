Rails.application.routes.draw do
  resources :users
  get "reports", controller: :reports, action: :index

  namespace :reports do
    resources :games, only: [:index]
    namespace :games do
      resources :round_counts, only: [:index]
    end
  end

  namespace :api do
    namespace :users do
      resources :suggested, only: [:index]
    end

    namespace :reports do
      # resources :games, only: [:index, :show]
      # resources :rounds, only: [:index, :show]
      # resources :scores, only: [:index, :show]
      namespace :games do
        resources :rounds
        resources :round_counts, only: [:index, :create]
        resources :users
      end
    end
  end

  resources :games do
    put :finish
    resources :rounds do
      put :finish
      resources :scores
    end
    resources :players
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  root "games#index"
end
