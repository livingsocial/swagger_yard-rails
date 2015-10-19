SwaggerYard.configure do |config|
  config.reload = true
  config.swagger_version = "1.2"
  config.api_version = "1.0"
  config.swagger_spec_base_path = "http://localhost:3000/swagger/api"
  config.api_base_path = "http://localhost:3000/api"
end
