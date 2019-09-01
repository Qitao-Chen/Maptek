Rails.application.routes.draw do
  root  'homepage#index'
  # get 'demo/index'


  get "login", to: "homepage#login"
  get "register", to: "homepage#register"

  # get 'homepage/Register'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
