SwaggerYard::Rails::Engine.routes.draw do
   get '/api', to: 'swagger#index'
   get '/api/*resource', to: 'swagger#show'
end
