Rails.application.routes.draw do
  devise_for :users
  root "events#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")

  resources :venues, only: %i[index show] do
    post "events", to: "events#create"
  end

  resources :events, only: %i[index show destroy] do
    resources :participants, only: %i[create destroy]
    post "messages", to: "messages#create"
  end

  get "home", to: "pages#home"

  get "profile", to: "users#profile"
  get "users/:id", to: "users#show", as: "user"
  get "index", to: "users#index"

  patch "events/:id/lock", to: "events#lock_event", as: "lock_event"
  patch "participants/:id/accept", to: "participants#accept", as: "accept"
  patch "participants/:id/pending", to: "participants#set_to_pending", as: "set_to_pending"
  patch "participants/:id/decline", to: "participants#decline", as: "decline"
end
