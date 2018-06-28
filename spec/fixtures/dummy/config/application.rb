require "action_controller/railtie"

# Load SwaggerYard::Rails
require File.expand_path('../../../../../lib/swagger_yard/rails', __FILE__)

module Dummy
  class Application < Rails::Application
    config.root = File.expand_path('../../', __FILE__)

    if Rails::VERSION::MAJOR < 5
      # Disable the asset pipeline.
      config.assets.enabled = false
    end

    if config.respond_to?(:load_defaults)
      config.load_defaults "#{Rails::VERSION::MAJOR}.#{Rails::VERSION::MINOR}".to_f
    end
  end
end

Dummy::Application.initialize!
