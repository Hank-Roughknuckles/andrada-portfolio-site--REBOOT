source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.1'

# Use PostgreSQL for database management
gem 'pg'

#For the ability to send emails
gem 'mail'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Twitter bootstrap
gem 'bootstrap-sass'

#Paperclip for the user to upload files
gem 'paperclip', "~> 3.0"

#Rambling slider for image carousel
# gem 'rambling-slider-rails', :git => 'https://github.com/gonzedge/rambling-slider-rails'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

#gridster for showing some works
gem 'gridster-rails', :git => 'git://github.com/Hank-Roughknuckles/gridster-rails'

# Devise for user authentication
gem 'devise'

# Use jquery as the JavaScript library
gem 'jquery-rails'

#Use Ancestry to allow for tree based navigation
gem 'ancestry'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
# gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

#manage environment variables with Figaro
gem 'figaro'

group :development, :test do
  gem 'rspec-rails', '2.13.1'
  gem "spork", "> 0.9.0.rc"
  gem 'guard-rspec'
  gem "guard-spork"
end

group :test do
  gem 'selenium-webdriver', '2.35.1'
  gem 'factory_girl_rails'
  gem 'capybara', '2.1.0'
  gem 'database_cleaner'
end

group :test, :darwin do
  gem 'rb-fsevent'
end

group :production do
  gem 'rails_12factor', '0.0.2'
end

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.1.2'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]
