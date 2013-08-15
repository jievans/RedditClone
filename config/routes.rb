Reddit::Application.routes.draw do
  resources :users
  resources :subs
  resources :links


  resource :session

end
