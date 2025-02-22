Sidekiq.configure_server do |config|
    if Rails.env.production?
        config.redis = {url: Rails.application.credentials.dig(:redis, :url)}
    else
        config.redis = {url: 'redis://localhost:6379'}
    end
    config.logger.level = Logger::WARN
end

Sidekiq.configure_client do |config|
    if Rails.env.production?
        config.redis = {url: Rails.application.credentials.dig(:redis, :url)}
    else
        config.redis = {url: 'redis://localhost:6379'}
    end
end
