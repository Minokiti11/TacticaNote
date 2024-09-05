require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module TacticaChat
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0
      config.i18n.default_locale = :ja

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # CORS設定
    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*'  # すべてのオリジンからのアクセスを許可
        resource '*', 
          headers: :any, 
          methods: [:get, :post, :patch, :put, :delete, :options, :head],
          credentials: false
      end
    end

    config.active_storage.service_urls_expire_in = 2.hours

  end
end
