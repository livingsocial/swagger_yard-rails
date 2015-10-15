module SwaggerYard
  module Rails
    class Engine < ::Rails::Engine
      isolate_namespace SwaggerYard::Rails
      initializer "swagger_yard-rails.finisher_hook" do |app|
        SwaggerYard.register_custom_yard_tags!
      end
    end
  end
end
