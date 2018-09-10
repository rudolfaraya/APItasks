Rails.application.routes.draw do
  resources :tasks
  put '/tasks/:id/init', to: 'tasks#init'
  put '/tasks/:id/finish', to: 'tasks#finish'
  put '/tasks/:id/cancel', to: 'tasks#cancel'

  post 'auth/login', to: 'authentication#authenticate'
  post 'signup', to: 'users#create'

end
