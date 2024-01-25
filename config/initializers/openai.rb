OpenAI.configure do |config|
    config.access_token = Rails.application.credentials.chatgpt_api_key
end