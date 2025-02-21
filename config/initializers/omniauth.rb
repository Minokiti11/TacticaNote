OmniAuth.config.allowed_request_methods = [:get, :post]
OmniAuth.config.silence_get_warning = true

# Enable detailed debug logging for OmniAuth
OmniAuth.config.logger = Rails.logger
Rails.logger.level = Logger::DEBUG

# Add full backtrace for OmniAuth errors
OmniAuth.config.on_failure = proc { |env|
  OmniAuth::FailureEndpoint.new(env).redirect_to_failure
}

OmniAuth.config.full_host = "https://tactica-note.com"