Wheninrome2::Application.routes.draw do
  get "static/home"
  get "static/contact"
  get "static/about"

  devise_for :users
  
  resources :trips, except: [ :edit, :update, :destroy ] do
    member do  #member always pass id, collection do, dont pass id.
      get :accept #controller action, becomes accept_trip_path #JV why isnt this post
      get :decline #JV why isnt this post... for simplicity sake
      get :checkout #I'm gonna think of it as this is an action on the trips controller so im gonna put it under resources trips. # checkout_trip_url (full url instead of _path)
      post :reserve # THIS JUST SAVES THE CARD AND REDIRECTS does not render a view reserve_trip_path
      get :thanks #success screen
      get :charge #host hits charge on users who have 'paid'
    end
  end

  resources :cities
  resources :charges

  root 'static#home'

end






#JV how do i make checkout initiate the set session member route?