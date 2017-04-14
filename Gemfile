source 'https://rubygems.org'
ruby '2.4.0'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.0.1'
gem 'pg'
gem 'devise'
gem 'omniauth'
gem 'omniauth-spotify'
gem 'puma', '~> 3.0'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'mini_racer', platforms: :ruby
gem 'react_on_rails'
gem 'chosen-rails'

gem 'jquery-rails'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'bcrypt', '~> 3.1.7'
gem 'simple_form', '>= 3.4.0'
gem 'nokogiri' # needed for premailer-rails
gem 'premailer-rails'
gem 'whenever', :require => false

gem 'oh_my_rockness', git: 'https://github.com/smitchsmith/oh_my_rockness.git'
gem 'rspotify', git: 'https://github.com/smitchsmith/rspotify.git'
gem 'aws-ses', :require => 'aws/ses'
gem 'rollbar'

group :development, :test do
  gem 'byebug', platform: :mri
  gem 'rspec-rails'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  gem 'letter_opener'
  gem 'foreman'
end
