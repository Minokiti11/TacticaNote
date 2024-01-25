Rails.application.routes.draw do
  resources :videos
  devise_for :users

  root to: "home#index"
  get "about" => "home#about"

  resources :users
  resources :groups do
    get "join" => "groups#join"
    get 'chat' => "groups#chat"
    get 'groups/show' => 'groups#show'
    delete "all_destroy" => 'groups#all_destroy'
  end


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  mount ActionCable.server => '/cable'
end
