SwaggerYard::Rails::Engine.routes.draw do
  get '/doc', to: 'swagger#doc'

  scope default: {format: 'json'} do
    get '/swagger', to: 'swagger#index'
    get '/api', to: 'swagger#index'
  end
end
