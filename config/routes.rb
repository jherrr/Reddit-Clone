Rails.application.routes.draw do
  resource :user do
    resources :subs, only: [:new, :create, :destroy, :edit, :update]
    resources :posts, only: [:new, :create, :destroy, :edit, :update]
  end

  resource :session, only: [:new, :create, :destroy]

  resources :subs, only: [:show, :index]

  resources :posts, only: [:show]

end
