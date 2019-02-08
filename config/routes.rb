Rails.application.routes.draw do

  post '/webhooks/ordercreate' => "home#show"
  post '/webhooks/variantcreate' => "home#index"
  get '/webhooks'=>'home#show_all_webhooks'
  get '/showorder'=>'home#create_order'
  get '/manual_order'=>'home#manual_order'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
