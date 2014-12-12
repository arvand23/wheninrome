Wheninrome2::Application.routes.draw do
  get "static/home"
  get "static/contact"
  get "static/about"

  devise_for :users
  
  resources :trips, except: [ :edit, :update, :destroy ] do  #huh?
    member do
      get :accept #controller action, becomes accept_trip_path
      get :decline
    end
  end

  resources :cities

  root 'static#home'

end
