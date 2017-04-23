source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'

gem 'rails', '~> 5.0.1'
gem 'bootstrap-sass' , '3.3.6'
gem 'devise-bootstrap-views'
gem 'devise-i18n'

# Use sqlite3 as the database for Active Record
# Use Puma as the app server
gem 'puma', '~> 3.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use spreadsheet for reading instructor's roster.
gem 'spreadsheet'

# used to send emails
gem 'sendgrid-rails'

# Used to validate emails in student creation
gem 'email_validator'

# Used to zip submissions for grading
gem 'rubyzip', '>= 1.0.0' # will load new rubyzip version
gem 'zip-zip' # will load compatibility for old rubyzip API. 

# Used to connect to aws
gem 'aws-sdk-rails'

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'sqlite3'
  gem 'byebug', platform: :mri
  gem 'factory_girl_rails'
  gem 'cucumber-rails', require: false
  gem "capybara"
  gem 'database_cleaner'
  gem 'rspec-rails'
  
end

#uploades  files
gem 'carrierwave', '~> 0.9'

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :production do
  gem 'pg'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem 'devise'
gem "roo", "~> 2.7.0"


# Amazon S3 Storage.  Comment in the next gem, bundle install (might need to delete Gemfile.lock), and change the uploaders to configure this.
gem "fog-aws" 
gem 'aws-sdk', '< 2.0'
gem "mini_magick" 
gem "figaro" # manages environment variables
