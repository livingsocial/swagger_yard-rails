source 'https://rubygems.org'

# Specify your gem's dependencies in swagger_yard-rails.gemspec
gemspec

if ENV['RAILS_VERSION']
  gem 'rails', ENV['RAILS_VERSION']
elsif File.exist?('Gemfile.lock')
  # use whatever version is currently installed
  version = File.read('Gemfile.lock').scan(/DEPENDENCIES.*/m).first[/rails \((.*?)\)/m, 1]
  gem 'rails', version
else
  gem 'rails', '~> 4.2'
end
