require 'sidekiq/web'

Rails.application.routes.draw do
  get 'users/show'
  resources :videos
  resources :notes
  resources :practices
  # devise_for :users

  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations'
  }

  get "my_page" => "users#show"

  root to: "home#index"
  get "about" => "home#about"

  # resources :users
  resources :groups do
    member do
      post 'generate_invite_link' => 'groups#generate_invite_link'
    end
    get 'join/:invite_token', to: 'groups#join_by_invite', as: :join_group_by_invite
    get 'chat' => "groups#chat"
    get 'groups/show' => 'groups#show'
    get 'video' => "groups#video"
    get 'note' => "groups#note"
    get 'practice' => "groups#practice"
    delete "all_destroy" => 'groups#all_destroy'
  end
  
  resources :mentions, only: [:index]

  post '/notes/gpt_api_request_good', to: 'notes#gpt_api_request_good'
  post '/notes/gpt_api_request_bad', to: 'notes#gpt_api_request_bad'
  post '/notes/gpt_api_request_next', to: 'notes#gpt_api_request_next'
  mount ActionCable.server => '/cable'
  
  mount Sidekiq::Web => '/sidekiq'
end
