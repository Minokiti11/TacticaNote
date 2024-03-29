Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root to: "home#index"
  get "about" => "home#about"
  resources :users
  resources :groups do
    get "join" => "groups#join"
  end
end
