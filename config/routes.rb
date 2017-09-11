Rails.application.routes.draw do
  root 'destinations#index'
  resources :destinations

  namespace :api do
    namespace :v1 do
      get '/destinations', to: "destinations#index"
      post '/destinations', to: "destinations#create"
      get '/destinations/:id', to: "destinations#show"
      put '/destinations/:id', to: "destinations#update"
      delete '/destinations/:id', to: "destinations#destroy"
    end
  end
end
