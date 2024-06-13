# frozen_string_literal: true

source 'https://rubygems.org'

ruby '3.0.0'

# Rails framework
gem 'rails', '~> 7.1.3'

# Asset pipeline
gem "sprockets-rails"

# SQLite3 for Active Record
gem "sqlite3", "~> 1.4"

# Puma web server
gem "puma", ">= 5.0"

# JavaScript with ESM import maps
gem "importmap-rails"

# Hotwire
gem "turbo-rails"
gem "stimulus-rails"

# JSON APIs
gem "jbuilder"

# Timezone data for Windows
gem "tzinfo-data", platforms: %i[mswin mswin64 mingw x64_mingw jruby]

# Reduces boot times through caching
gem "bootsnap", require: false

# Authentication
gem 'devise'

group :development, :test do
  gem "debug", platforms: %i[mri mswin mswin64 mingw x64_mingw]
  gem 'factory_bot_rails'
  gem 'pry-byebug'
  gem 'rspec-rails', '~> 5.0.0'
  gem 'rubocop', require: false
  gem 'rubocop-rails', require: false
end

group :development do
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
end
