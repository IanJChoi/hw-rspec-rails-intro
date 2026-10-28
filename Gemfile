source 'https://rubygems.org'

ruby '3.3.8'

gem 'rails', '~> 7.1.5'
gem 'ffi', '1.14.2'

gem 'sass-rails', '~> 5.0.3'
gem 'uglifier', '>= 2.7.1'

gem 'jquery-rails'
gem 'bigdecimal', '1.3.5'

gem 'faraday', '1.8.0'

# Heroku web server
gem 'puma', '~> 7.0'

group :development, :test do
  gem 'byebug'
  gem 'database_cleaner'
  gem 'cucumber-rails', require: false
  gem 'rspec-rails'
  gem 'pry'
  gem 'pry-byebug'

  gem 'sqlite3', '~> 1.7'
end

group :development do
  gem 'web-console', '~> 4'
end

group :test do
  gem 'rails-controller-testing'
  gem 'guard-rspec'
  gem 'webmock'
end

group :production do
  gem 'pg', '~> 1.5'
end
