Rails.application.routes.draw do
  devise_for :users
  root "events#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")

  resources :venues, only: %i[index show]

  resources :events, only: %i[index show] do
    resources :teams, only: %i[create]
  end

  get "profile", to: "users#profile"
  get "index", to: "users#index"

end
