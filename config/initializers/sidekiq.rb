Sidekiq.configure_server do |config|
    config.redis = {url: 'redis://red-cprangdumphs73c22la0:6379'}
end

Sidekiq.configure_client do |config|
    config.redis = {url: 'redis://red-cprangdumphs73c22la0:6379'}
end

p 'REDIS_URL: ',ENV['REDIS_URL'] 