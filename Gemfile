# frozen_string_literal: true

ruby File.read('.ruby-version').strip

source 'https://rubygems.org'

# Utilities and Utilities
gem 'figaro', '~> 1.2'
gem 'pry', '~> 0.14.2'
gem 'rake', '~> 13.0'
gem 'securerandom'

# Web Application
gem 'faye', '~> 1.4'
gem 'logger', '~> 1.6'
gem 'multi_json', '~> 1.15'
gem 'puma', '~> 6.4'
gem 'rack-session', '~> 0.3'
gem 'roar', '~> 1.2'
gem 'roda', '~> 3.85'
gem 'slim', '~> 5.2'

# Data Validation
gem 'dry-monads', '~> 1.6'
gem 'dry-struct', '~> 1.6'
gem 'dry-transaction', '~> 0.16.0'
gem 'dry-types', '~> 1.7'
gem 'dry-validation', '~> 1.10'
gem 'ostruct', '~> 0.6.1'

# Network dependency
gem 'http'

# Database
gem 'hirb', '~> 0.7.3'
gem 'sequel', '~> 5.85'

group :development, :test do
  gem 'sqlite3', '~> 2.1'
end

# Async
gem 'shoryuken', '~> 6.2'

gem 'concurrent-ruby', '~> 1.3'

gem 'aws-sdk-sqs', '~> 1.89'

# Testing
group :test do
  gem 'minitest'
  gem 'minitest-rg'
  gem 'rack-test', '~> 2.1'
  gem 'rerun', '~> 0.14.0'
  gem 'simplecov', '~> 0.22.0'
  gem 'vcr', '~> 6.3'
  gem 'webmock', '~> 3.24'
end

# Code Quality
group :development do
  gem 'flog', '~> 4.8'
  gem 'reek', '~> 6.3'
  gem 'rubocop', '~> 1.66'
end

# heroku
group :production do
  gem 'pg', '~> 1.5'
end
