Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "users#new"
    resources :users
  end
end
