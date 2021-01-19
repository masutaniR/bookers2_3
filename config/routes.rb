Rails.application.routes.draw do
  get 'books/index'
  get 'books/show'
  get 'books/edit'
  devise_for :users
  root 'homes#top'
  get '/home/about' => 'homes#about'
  resources :users, only: [:index, :show, :edit, :update]
  resources :books, except: [:new]
end
