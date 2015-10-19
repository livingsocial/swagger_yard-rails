SwaggerYard::Rails::Engine.routes.draw do
  get '/doc', to: 'swagger#doc'

  scope defult: {format: 'json'} do
    get '/api', to: 'swagger#index'
    get '/api/*resource', to: 'swagger#show'
  end
end
