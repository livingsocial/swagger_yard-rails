Dummy::Application.routes.draw do
  mount SwaggerYard::Rails::Engine, at: "/swagger"
end
