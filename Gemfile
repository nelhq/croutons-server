source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.0.3"

gem "rails", "~> 7.0.4"
gem "sprockets-rails"
gem "administrate"
gem "mysql2", "~> 0.5"
gem "puma", "~> 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "jbuilder"
gem 'graphql'
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]
gem "bootsnap", require: false
gem 'dotenv-rails'
gem 'devise'
gem 'devise-i18n'
gem 'devise_token_auth'
gem "rack-cors"
gem 'administrate-field-active_storage'
gem "image_processing"
gem "google-cloud-storage", "~> 1.3", require: false
gem 'line-bot-api'
gem 'faraday_middleware'
gem "sentry-ruby"
gem "sentry-rails"

group :development, :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem 'faker'
  gem 'factory_bot_rails'
  gem 'pry-rails'
end

group :test do
  gem 'database_cleaner'
  gem 'rspec-rails'
end

group :development do
  gem "web-console"
  gem 'graphiql-rails'
end
