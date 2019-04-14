Rails.application.routes.draw do
  scope '/user' do
    post '/register', to: 'users#register'
    post '/login', to: 'users#login'
    get '/me', to: 'users#me'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
