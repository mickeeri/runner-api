Rails.application.routes.draw do

  get 'sessions/new'
  # Static pages
  root 'static_pages#home'
  get 'signup' => 'users#new'
  get 'api/guide' => 'static_pages#guide'

  # Login pages
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'

  resources :users, except: [:new]
  resources :user_applications

  # API routes
  namespace :api do
    namespace :v1 do
      resources :locations
      resources :races
    end
  end

  # Knock for api authorization
  mount Knock::Engine => "/api/v1/"
end
