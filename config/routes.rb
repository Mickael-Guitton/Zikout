Rails.application.routes.draw do
  devise_for :users
  root "events#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  resources :venues, only: %i[index show] do
    resources :events, only: %i[create]
  end

  resources :events, only: %i[index show destroy] do
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
  end

  get "index", to: "users#index"


  patch "participants/:id/accept", to: "participants#accept", as: "accept"
  patch "participants/:id/pending", to: "participants#set_to_pending", as: "set_to_pending"
  patch "participants/:id/decline", to: "participants#decline", as: "decline"
end
