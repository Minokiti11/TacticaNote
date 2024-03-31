Rails.application.routes.draw do
  resources :videos
  resources :notes
  # devise_for :users

  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  root to: "home#index"
  get "about" => "home#about"

  resources :users
  resources :groups do
    get "join" => "groups#join"
    get 'chat' => "groups#chat"
    get 'groups/show' => 'groups#show'
    get 'video' => "groups#video"
    delete "all_destroy" => 'groups#all_destroy'
  end

  mount ActionCable.server => '/cable'
end
