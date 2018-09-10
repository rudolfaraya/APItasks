Rails.application.routes.draw do
  resources :tasks

  post 'auth/login', to: 'authentication#authenticate'
  post 'signup', to: 'users#create'
end
