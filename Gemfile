source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.2"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.0.8"

gem 'wdm', '>= 0.1.0' if Gem.win_platform?

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem "sprockets-rails"

gem 'pg', '~> 1.1'

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", "~> 5.0"

# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem "importmap-rails"

gem 'bootstrap', '5.1.3' # Biblioteca de estilos para diseño web responsive

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails"

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "jbuilder", '~> 2.7'

# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'

# Authentication
gem 'devise'

# Authorization
gem 'pundit'

# Audit Active Record Models
gem 'audited'

# Translations
gem 'rails-i18n'

# Pagination
gem 'pagy', '~> 8.2.0'

# Error tracking
# gem 'newrelic_rpm', '~> 9.8.0'

# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'

# Background process
# gem 'sidekiq'

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

gem 'bcrypt_pbkdf'
gem 'ed25519'
gem 'openssl'

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
gem "image_processing", "~> 1.2"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  # gem "debug", platforms: %i[ mri mingw x64_mingw ]
  # gem 'byebug', platforms: [:mri, :mingw, :x64_mingw, :jruby]
  # gem 'rubocop', require: false
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler"

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
  gem 'capistrano'
  gem 'capistrano3-puma'
  gem 'capistrano-rails', require: false
  gem 'capistrano-bundler', require: false
  gem 'capistrano-rvm'
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  # gem "capybara"
  # gem "selenium-webdriver"

    # Factory bot
    gem 'factory_bot_rails'
    # Test controllers
    gem 'rails-controller-testing'
    gem 'faker'
    #gem 'minitest'
  
    #rspec
    %w[rspec-core rspec-expectations rspec-mocks rspec-rails rspec-support].each do |lib|
        gem lib, git: "https://github.com/rspec/#{lib}.git", branch: 'main' # Previously '4-0-dev' or '4-0-maintenance' branch
    end
end
