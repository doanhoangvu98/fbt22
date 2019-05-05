Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#home"

    get "/signup", to: "users#new"
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
    get "/tours", to: "tours#index"
    get "/about", to: "static_pages#about"
    get "/contact", to: "static_pages#contact"
    resources :users, expect: %i(index destroy)
    resources :tours, only: %i(show index) do
      resources :reviews
    end
    resources :bookings, only: %i(create index) do
      member do
        patch :change_status
      end
    end
    resources :reviews, only: %i(new create destroy edit update)
    resources :comments
    namespace :admin do
      root "index#home"
      resources :categories, only: %i(new create)
      resources :locations
      resources :travellings
      resources :tours do
        member do
          patch :change_status
        end
      end
    end
    resources :users
    resources :tours, only: %i(show index)
    resources :bookings, only: %i(new create index) do
      member do
        patch :change_status
      end
    end
    resources :tours do
      resources :reviews, only: %i(show)
    end
    resources :reviews do
      resources :likes, only: %i(new create show destroy)
    end
    resources :reviews
    resources :reviews do
      resources :likes
    end
  end
end
