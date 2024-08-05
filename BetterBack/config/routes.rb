Rails.application.routes.draw do
  resources :users
  get 'user/reset/:token', to: 'users#edit_password', as: 'new_password'
  patch 'user/reset/:token', to: 'users#reset_password', as: 'update_password'
  post 'forgot_password', to: 'users#forgot_password'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  post "login" => "sessions#create"
end
