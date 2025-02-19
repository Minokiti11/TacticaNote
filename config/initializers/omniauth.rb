# Development環境でのみCSRF保護を無効化
if Rails.env.development?
  OmniAuth.config.allowed_request_methods = [:get, :post]
  OmniAuth.config.silence_get_warning = true
  
  # Enable detailed debug logging for OmniAuth
  OmniAuth.config.logger = Rails.logger
  Rails.logger.level = Logger::DEBUG
end

# Add full backtrace for OmniAuth errors
OmniAuth.config.on_failure = proc { |env|
  OmniAuth::FailureEndpoint.new(env).redirect_to_failure
}