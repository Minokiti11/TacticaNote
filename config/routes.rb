require 'sidekiq/web'

require 'uppy/s3_multipart'

Rails.application.routes.draw do
  # AWS S3 Multipart Upload
  if Rails.application.credentials.dig(:aws, :access_key_id).present?
    bucket = Aws::S3::Bucket.new(
      access_key_id: Rails.application.credentials.dig(:aws, :access_key_id),
      name: Rails.application.credentials.dig(:aws, :bucket),
      region: Rails.application.credentials.dig(:aws, :region),
      secret_access_key: Rails.application.credentials.dig(:aws, :secret_access_key),
      use_accelerate_endpoint: false,
    )
    UPPY_S3_MULTIPART_APP = Uppy::S3Multipart::App.new(bucket: bucket, options: {
      create_multipart_upload: {
        storage_class: "STANDARD",
      },
    })
    mount UPPY_S3_MULTIPART_APP => '/s3/multipart'
  end

  resources :contacts, only: [:new, :create]
  get 'summaries/create'
  get 'users/show'
  resources :videos
  post '/videos/register_blob', to: 'videos#register_blob'
  resources :notes
  resources :practices
  resources :daily_practice_items, only: :destroy
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
    member do
      get 'load_more_date_groups'
    end
    get 'join/:invite_token', to: 'groups#join_by_invite', as: :join_group_by_invite
    get 'chat' => "groups#chat"
    get 'groups/show' => 'groups#show'
    get 'video' => "groups#video"
    get 'note' => "groups#note"
    get 'practice' => "groups#practice"
    delete "all_destroy" => 'groups#all_destroy'
    post 'create_daily_practice_item', on: :member
  end

  resources :ai_practices, only: [:create]
  
  resources :mentions, only: [:index]

  resources :summaries, only: [:create]

  resources :timestamps, only: [:create, :update, :destroy] do
    member do
      post 'update'
    end
  end

  get 'search_notes', to: 'notes#search'

  post '/notes/gpt_api_request_good', to: 'notes#gpt_api_request_good'
  post '/notes/gpt_api_request_bad', to: 'notes#gpt_api_request_bad'
  post '/notes/gpt_api_request_next', to: 'notes#gpt_api_request_next'
  mount ActionCable.server => '/cable'
  
  mount Sidekiq::Web => '/sidekiq'

  get "up" => "rails/health#show", as: :rails_health_check

  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
end
