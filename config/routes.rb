Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/pv/:client_id' => 'pv#get'

  get '/uu/:client_id' => 'uu#get'

  post '/index/:client_id' => 'index#create'
  delete '/index/:client_id' => 'index#delete'
  get '/index' => 'index#list'
end
