Rails.application.routes.draw do
  devise_for :users
  root "events#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")

  resources :venues, only: %i[index show new]  do
    post "events", to: "events#create"
    patch "events/:id", to: "events#update", as: "update_event"
  end

  resources :events, only: %i[index show edit] do
    resources :participants, only: %i[create destroy]
    post "messages", to: "messages#create"
    member do
      patch :lock_event
    end
  end

  get "home", to: "pages#home"
  get "profile", to: "users#profile"
  get "users/:id", to: "users#show", as: "user"

  resources :users, only: %i[index show] do
    post "venues", to: "venues#create"
    patch "venues/:id", to: "venues#update", as: "update_venue"
    member do
      post "members", to: "members#create"
    end
  end

  get "index", to: "users#index"

  patch "participants/:id/accept", to: "participants#accept", as: "accept"
  patch "participants/:id/pending", to: "participants#set_to_pending", as: "set_to_pending"
  patch "participants/:id/decline", to: "participants#decline", as: "decline"

  delete "venues/:id", to: "venues#destroy"
  delete "events/:id", to: "events#destroy"

end
