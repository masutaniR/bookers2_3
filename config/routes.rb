Rails.application.routes.draw do
  get 'books/index'
  get 'books/show'
  get 'books/edit'

  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions',
  }

  devise_scope :user do
    get "sign_in", :to => "users/sessions#new"
    get "sign_out", :to => "users/sessions#destroy"
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end

  root 'homes#top'
  get '/home/about' => 'homes#about'
  resources :users, only: [:index, :show, :edit, :update]
  get '/users/:id/hide_confirm' => 'users#hide_confirm', as: 'users_hide_confirm'
  patch "/users/:id/hide" => "users#hide", as: 'users_hide'
  resources :books, except: [:new] do
    resources :comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end
end
