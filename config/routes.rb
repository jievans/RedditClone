Reddit::Application.routes.draw do
  resources :users
  resources :subs
  resources :links
  resources :comments

  resource :session
end
