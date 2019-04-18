Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "users#new"
    get "/signup", to: "users#new"
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
    get "/home", to: "static_pages#home"
    get "/about", to: "static_pages#about"
    get "/contact", to: "static_pages#contact"

    resources :users
  end
end
