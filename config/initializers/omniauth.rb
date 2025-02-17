Rails.application.config.middleware.use OmniAuth::Builder do
    OmniAuth.config.allowed_request_methods = [:post, :get]
    provider :google_oauth2, Rails.application.credentials.dig(:google, :client_id), Rails.application.credentials.dig(:google, :client_secret),
    {
        scope: 'email,profile',
        prompt: 'select_account',
        provider_ignores_state: false  # CSRFエラーを防ぐための設定
    }
end