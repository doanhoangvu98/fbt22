Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#home"

    devise_for :users, controllers: {
      sessions: "users/sessions",
      registrations: "users/registrations",
      confirmations: "users/confirmations"
    }
    devise_scope :user do
      get "sign_in", to: "users/sessions#new"
    end

    get "/tours", to: "tours#index"
    namespace :admin do
      root "index#home"
      resources :users, only: %i(index destroy)
      resources :reviews, only: %i(index destroy)
      resources :categories
      resources :locations
      resources :travellings
      resources :bookings, only: :index do
        member do
          patch :change_status
        end
      end
      resources :tours do
        member do
          patch :change_status
        end
      end
    end
    resources :users, expect: %i(index destroy)
    resources :comments, only: :create
    resources :tours, only: %i(show index) do
      resources :reviews
    end
    resources :reviews do
      resources :likes, only: %i(new create show destroy)
    end
    resources :bookings, only: %i(new create index) do
      member do
        patch :change_status
      end
    end
  end
end
