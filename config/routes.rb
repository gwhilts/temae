Rails.application.routes.draw do
  root 'tasks#index'

  devise_for :users
  
  get '/tasks/toggle/:id(.:format)', to: 'tasks#toggle', as: 'task_toggle'
  delete 'tasks/completed', to: 'tasks#cleanup', as: 'cleanup_tasks'
  resources :tasks
end
