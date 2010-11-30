Rails3PracticeTdd::Application.routes.draw do
  devise_for :users

  resources :forums, :only => [:index, :show] do
    resources :posts
  end

  namespace :admin do
    resources :forums do
      resources :posts, :except => [:new, :create]
    end
  end

  root :to => "forums#index"

end
