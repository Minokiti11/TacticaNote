Rails.application.config.middleware.use OmniAuth::Builder do
    OmniAuth.config.allowed_request_methods = [:post]
    OmniAuth.config.request_validation_phase = nil if Rails.env.development?
end