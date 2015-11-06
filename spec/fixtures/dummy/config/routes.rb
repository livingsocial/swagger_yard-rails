Dummy::Application.routes.draw do
  resources :pets, only: [:index, :show, :create]
  get '/transports', to: 'transports#index', as: 'transports_index'
  mount SwaggerYard::Rails::Engine, at: "/swagger"
end
