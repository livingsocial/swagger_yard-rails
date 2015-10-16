require "action_controller/railtie"

# Load SwaggerYard::Rails
require File.expand_path('../../../../../lib/swagger_yard/rails', __FILE__)

module Dummy
  class Application < Rails::Application
    config.root = File.expand_path('../../', __FILE__)

    # Disable the asset pipeline.
    config.assets.enabled = false
  end
end

Dummy::Application.initialize!
