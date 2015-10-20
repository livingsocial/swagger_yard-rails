module SwaggerYard
  module Rails
    class Engine < ::Rails::Engine
      isolate_namespace SwaggerYard::Rails
      initializer "swagger_yard-rails.finisher_hook" do |app|
        SwaggerYard.register_custom_yard_tags!
      end

      initializer "swagger_yard-rails.paths" do |app|
        SwaggerYard.configure do |config|
          config.controller_path = ::Rails.root + 'app/controllers/**/*'
          config.model_path      = ::Rails.root + 'app/models/**/*'
        end
      end
    end
  end
end
