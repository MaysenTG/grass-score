source "https://rubygems.org"

gem "rails", "~> 7.2.0.beta3"
gem "sprockets-rails"
gem "pg", "~> 1.5"
gem "puma", ">= 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "jbuilder"
gem "redis", ">= 4.0.1"
gem "tzinfo-data", platforms: %i[ windows jruby ]
gem "bootsnap", require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

group :development, :test do
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"
  gem "brakeman", require: false
  gem "rubocop-rails-omakase", require: false
end

group :development do
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"

  gem "rspec-rails"
  gem "shoulda-matchers", "~> 6.0"
  gem "factory_bot_rails"
end

gem "byebug", "~> 11.1"

gem "devise", "~> 4.9"

gem "faker", "~> 3.4"

gem "dockerfile-rails", ">= 1.6", :group => :development
