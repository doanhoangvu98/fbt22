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
    namespace :admin do
      root "index#home"
      resources :categories, only: %i(new create)
      resources :locations
      resources :travellings
      resources :tours do
        member do
          patch :status
        end
      end
    end
    resources :users
    resources :tours, only: %i(show index)
  end
end
