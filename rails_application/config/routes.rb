Rails.application.routes.draw do

  get 'sessions/new'
  # Static pages
  root 'static_pages#home'
  get 'signup' => 'users#new'

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
  mount Knock::Engine => "/login"
end
