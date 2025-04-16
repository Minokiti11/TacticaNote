source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.3.7"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 8.0.0"

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem "sprockets-rails"

# Use sqlite3 as the database for Active Record
# gem "sqlite3", "~> 1.4"
gem 'sqlite3'

gem 'pg'

gem "dotenv-rails"

gem 'concurrent-ruby', '1.3.4'

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", "~> 5.0"

# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem "importmap-rails"

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails"

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "jbuilder"

# Use Redis adapter to run Action Cable in production
gem "redis", "~> 4.0"

gem "sidekiq" # 非同期ジョブの処理をサポートするgem

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Use Sass to process CSS
# gem "sassc-rails"
gem 'actiontext'
# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
gem "image_processing"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"
  
  # Preview email in the browser instead of sending it
  gem "letter_opener_web"

  gem 'capistrano', '~> 3.9'
  gem 'capistrano-rails'
  gem 'capistrano-rbenv'
  gem 'capistrano-bundler'
  gem 'capistrano3-puma'

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler"

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers", "~> 5.3.0"
end

gem 'devise'
gem 'devise-i18n' # devise日本語化のためのGem

gem 'actioncable'
gem "bootstrap", "~> 5.3"

gem "refile", require: "refile/rails", github: 'manfe/refile'
gem "refile-mini_magick"

gem 'net-http'

gem "ruby-openai"

gem 'aws-sdk-rails'
gem 'aws-sdk-s3', '~> 1'
gem 'uppy-s3_multipart', '~> 1.0'
gem 'aws-sdk-core', '~> 3'

gem 'omniauth'
gem 'omniauth-rails_csrf_protection'
gem 'omniauth-github'
gem 'omniauth-google-oauth2'

# gem 'serviceworker-rails'

gem 'rack-cors', require: 'rack/cors'

gem 'meta-tags'

gem 'pry-rails'

gem 'whenever', require: false

gem 'sassc-rails'
# gem 'bootstrap-sass'

gem 'redcarpet'

gem 'mini_racer'
gem "kamal", "~> 2.5"

gem 'thruster'

gem 'high_voltage'

gem 'sitemap_generator'

gem "jsbundling-rails", "~> 1.3"
