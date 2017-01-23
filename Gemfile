# frozen_string_literal: true
source 'https://rubygems.org'

ruby '2.3.3'
gem 'rails'

gem 'pg'                     # Use PostgreSQL as the database for Active Record
gem 'puma', '~> 3.0'         # Use Puma as the app server

gem 'coffee-rails', '~> 4.2' # Use CoffeeScript for .coffee assets and views
gem 'jquery-rails'           # Use jquery as the JavaScript library
gem 'sass-rails', '~> 5.0'   # Use SCSS for stylesheets
gem 'turbolinks', '~> 5'     # Turbolinks makes navigating your web application faster
gem 'uglifier', '>= 1.3.0'   # Use Uglifier as compressor for JavaScript assets

gem 'jbuilder', '~> 2.5'     # Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder

# API
gem 'grape'
gem 'grape-entity'

group :development, :test do
  gem 'pry-byebug'           # Use by adding binding.pry in code to debug
  gem 'pry-rails'
  gem 'rspec-rails'
end

group :development do
  gem 'spring'               # Spring speeds up development by keeping your application running in the background
  gem 'spring-watcher-listen', '~> 2.0.0'

  gem 'rubocop', require: false
end
