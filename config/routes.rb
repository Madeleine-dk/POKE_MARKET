Rails.application.routes.draw do
  devise_for :users
  root to: "cards#index"



  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  get '/dashboard', to: 'dashboard#show', as: :dashboard

  resources :cards do
    resources :rentals, only: %i[create]
    resources :reviews, only: [:create]
  end
  # Defines the root path route ("/")
  # root "posts#index"
end
