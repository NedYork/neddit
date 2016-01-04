Rails.application.routes.draw do
  root to: "subs#index"

  resources :users, only: [:new, :create, :show]
  resource :session, only: [:new, :create, :destroy]
  resources :subs, except: [:destroy] do
    resources :posts, only: [:new]
  end
  resources :posts, except: [:index, :new]

end
