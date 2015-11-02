SwaggerYard.configure do |config|
  config.title = "Dummy App"
  config.description = "Dummy application for testing SwaggerYard and Rails"
  config.reload = true
  config.api_version = "1.0"
  config.api_base_path = "http://localhost:3000/api"
end
