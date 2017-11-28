Rails.application.routes.draw do

  # eventually root 'main'
  # which will redirect to login if user is not logged in

  get 'admin', :to => 'access#menu'
  get 'access/menu'
  get 'access/login'
  post 'access/attempt_login'
  get 'access/logout'
  get '/denied', :to => redirect('/access-denied.html')

  resources :users do
      member do
          get :delete
      end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
