source 'https://rubygems.org'

ruby "1.9.3"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.0'

# Use postgresql as the database for Active Record
gem 'pg'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# for_pagination
gem 'will_paginate', '~> 3.0.5'

# icons from font-awesome
gem "font-awesome-sass-rails", "~> 3.0.2.2"

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

# Sidekiq will use Redis for background jobs
gem 'sidekiq'
gem 'redis'
gem 'sinatra', require: false
gem 'slim'

# AWS S3 is where we cache files in preparation for upload to Dropbox
gem 'aws-s3', '~> 0.6.3'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

group :test do
  gem 'shoulda-matchers'
end

group :development, :test do
  gem 'rspec-rails', '~> 2.0'
  gem 'capybara'
  gem 'factory_girl_rails'
  gem 'coveralls', require: false
end

group :production do
  gem 'rails_12factor' # for heroku
  gem 'unicorn' # web server
end

group :assets do
  gem 'sass-rails', '~> 4.0.0'
  gem "compass-rails", "~> 2.0.alpha.0"
  gem "bourbon", "~> 3.1.8"
end

gem "feedzirra-podcast", "~> 0.0.9"
gem 'dotenv-rails'
gem 'dropbox-sdk'
gem 'omniauth'
gem 'omniauth-dropbox-oauth2'

gem 'ruby-mp3info'

#for using cron with sideqik
gem 'whenever', :require => false



# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]
gem 'pry'
