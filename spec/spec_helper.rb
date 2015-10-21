# $LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
ENV['RAILS_ENV'] ||= 'development'

require 'bundler/setup'
require File.expand_path('../fixtures/dummy/config/application.rb', __FILE__)

require 'rspec/rails'
require 'rspec/its'
require 'apivore'
require 'mocha'
require 'bourne'

RSpec.configure do |config|
  config.run_all_when_everything_filtered = true
  config.filter_run :focus

  config.mock_with :mocha

  config.order = 'random'
end
