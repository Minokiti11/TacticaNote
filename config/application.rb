require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module TacticaChat
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0
    config.i18n.default_locale = :en
    config.i18n.fallbacks = true
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w[assets tasks])

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    config.time_zone = 'Tokyo'
    # config.eager_load_paths << Rails.root.join("extras")

    config.active_job.queue_adapter = :sidekiq

    # CORS設定
    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins ENV['CORS_ALLOWED_ORIGINS']&.split(',') || ['http://localhost:3000', 'https://tactica-note.com']
        resource '*',
          headers: :any,
          methods: [:get, :post, :patch, :put, :delete, :options, :head],
          credentials: true,
          expose: ['Authorization']
      end
    end

    # セッション設定
    config.session_store :cookie_store, key: '_tactica_note_session'
    config.middleware.use ActionDispatch::Cookies
    config.middleware.use config.session_store, config.session_options

    config.active_storage.service_urls_expire_in = 2.hours
    config.active_storage.previewers << ActiveStorage::Previewer::VideoPreviewer
  end
end

