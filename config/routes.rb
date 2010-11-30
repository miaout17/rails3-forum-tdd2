Rails3PracticeTdd::Application.routes.draw do
  devise_for :users

  root :to => "forums#index"

  resources :forums do
    resources :posts
  end
end
