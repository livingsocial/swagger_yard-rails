SwaggerYard::Rails::Engine.routes.draw do
  get '/doc', to: 'swagger#doc'

  scope default: {format: 'json'} do
    get '/swagger.json', to: 'swagger#index', version: '2.0'
    get '/api', to: 'swagger#index'
    get '/api/*resource', to: 'swagger#show'
  end
end
