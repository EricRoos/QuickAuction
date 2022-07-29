# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.0'

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem 'rails', '~> 7.0.3.1'

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem 'sprockets-rails'

# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'

# Use the Puma web server [https://github.com/puma/puma]
gem 'puma', '~> 5.0'

# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem 'importmap-rails'

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem 'turbo-rails'

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem 'stimulus-rails'

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem 'jbuilder'

# Use Redis adapter to run Action Cable in production
# gem "redis", "~> 4.0"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

# Use Sass to process CSS
# gem "sassc-rails"

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
gem 'image_processing', '~> 1.12.2'

group :production do
  gem 'scout_apm'
end
group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'debug', platforms: %i[mri mingw x64_mingw]
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem 'web-console'

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  gem 'rack-mini-profiler'

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'webdrivers'
end

gem 'factory_bot_rails', '~> 6.2', groups: %i[development test]

gem 'guard-livereload', '~> 2.5', groups: %i[development test]
gem 'guard-rails', '~> 0.8.1', groups: %i[development test]
gem 'guard-rspec', '~> 4.7', groups: %i[development test]
gem 'guard-rubocop', '~> 1.5', groups: %i[development test]
gem 'rspec-rails', '~> 5.1', groups: %i[development test]
gem 'rubocop', '~> 1.31', groups: %i[development test]

gem 'devise', '~> 4.8'

gem 'simplecov', '~> 0.21.2', group: :test

gem 'tailwindcss-rails', '~> 2.0'

gem 'pundit', '~> 2.2'

gem 'state_machines-activerecord', '~> 0.8.0'

gem 'view_component', '~> 2.59'

gem 'breadcrumbs', '~> 0.3.0'

gem 'heroicon', '~> 0.4.0'

gem 'noticed', '~> 1.5'

gem 'activeadmin', '~> 2.13'

gem 'sassc', '~> 2.4'

gem 'cucumber-rails', '~> 2.5', require: false, groups: %(test)

gem 'database_cleaner', '~> 2.0', groups: %i[test]

gem 'bundler-audit', '~> 0.9.1'

gem 'brakeman', '~> 5.2'

gem 'flipper', '~> 0.25.0'
gem 'flipper-active_record', '~> 0.25.0'

gem 'activeadmin_quill_editor', '~> 1.0'

gem 'rack-throttle', '~> 0.7.0'

gem 'flipper-ui', '~> 0.25.0'

gem 'fine_print', '~> 6.0'
