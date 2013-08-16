Reddit::Application.routes.draw do
  resources :users
  resources :subs
  resources :links do
    member do
      post 'upvote', :to => "links#upvote"
      post 'downvote', :to => "links#downvote"
    end
  end
  resources :comments

  resource :session
end
