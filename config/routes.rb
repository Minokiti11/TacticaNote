Rails.application.routes.draw do
  get 'google_login_api/callback'
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

  post '/google_login_api/callback', to: 'google_login_api#callback'

  mount ActionCable.server => '/cable'
end
