Rails.application.routes.draw do

  root to: "public/homes#top"

  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    get "/" => "homes#top"
    resources :posts, only: [:index, :new, :create, :show, :edit, :update] do
      resources :comments, only: [:create, :destroy]
    end
    resources :users,only:[:index, :show, :edit,:update]
  end

  devise_for :users,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  devise_scope :user do
    post 'users/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end

  get "users/unsubscribe" => "public/users#unsubscribe", as: "unsubscribe"
  patch "users/withdraw" => "public/users#withdraw" , as: "withdraw"

  scope module: :public do
    resources :posts,only:[:index, :show] do
      resource :favorites, only: [:create, :destroy]
    end
    resources :users,only:[:show, :edit, :update] do
      get  :favorites, on: :collection
    end
  end

  resources :posts do
    resources :comments, only:[:create, :destroy]
  end
   # resources :posts, except: [:index] do
  #    resource :favorites, only: [:create, :destroy]
   # end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
