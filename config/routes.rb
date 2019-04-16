Rails.application.routes.draw do
  scope '/user' do
    post '/register', to: 'users#register'
    post '/login', to: 'users#login'
    get '/me', to: 'users#me'
    delete '/deregister', to: 'users#deregister'
    get '/following', to: 'follows#follows'
  end
  scope '/tweet' do
    post '', to: 'tweets#create'
    post '/:tweet_id/reply', to: 'tweets#reply'
    delete '/:id', to: 'tweets#delete'
  end
  scope '/follow' do
    post '/:id', to: 'follows#create'
    delete '/:id', to: 'follows#destroy'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
