Reddit::Application.routes.draw do
  resources :users
  resources :subs
  resource :session
end
