Rails.application.routes.draw do

  get 'administrater/main'
  root  'homepage#index'
  # get 'demo/index'

  get 'homepage/test'
  get 'accounts/test'
  # get "login", to: "homepage#login"
  # get "register", to: "homepage#register"
  get 'accounts/login'
  get 'accounts/register'
  post 'create_account' => 'accounts#create_account'
  post 'create_login' => 'accounts#create_login'
  # get 'homepage/Register'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
