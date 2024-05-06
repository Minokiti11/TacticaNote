OpenAI.configure do |config|
    config.access_token = Rails.application.credentials.dig(:open_ai, :api_key)
end