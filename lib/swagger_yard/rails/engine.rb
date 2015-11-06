module SwaggerYard
  module Rails
    class Engine < ::Rails::Engine
      isolate_namespace SwaggerYard::Rails
      initializer "swagger_yard-rails.finisher_hook" do |app|
        SwaggerYard.register_custom_yard_tags!
        # Usage:
        # @route my-named-route
        ::YARD::Tags::Library.define_tag("Route", :route)
      end

      initializer "swagger_yard-rails.paths" do |app|
        SwaggerYard.configure do |config|
          config.controller_path ||= ::Rails.root + 'app/controllers/**/*'
          config.model_path      ||= ::Rails.root + 'app/models/**/*'

          config.path_discovery_function = RouteInspector.discovery_function
        end
      end

      rake_tasks do
        load File.expand_path('../tasks.rake', __FILE__)
      end
    end
  end
end
