Rails.application.routes.draw do
    root 'static_pages#home'
    get  '/help',    to: 'static_pages#help'
    get  '/about',   to: 'static_pages#about'
    get  '/contact', to: 'static_pages#contact'
    get  '/signup',  to: 'users#new'
    post '/signup',  to: 'users#create'
    get    'login'   => 'sessions#new'
    post   'login'   => 'sessions#create'
    delete 'logout'  => 'sessions#destroy'
  resources :microposts,          only: [:create, :destroy]
  resources :users
  resources :password_resets,     only: [:new, :create, :edit, :update]
  root 'users#index'
end
