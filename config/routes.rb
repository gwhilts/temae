Rails.application.routes.draw do
  root 'tasks#index'

  devise_for :users
  
  get '/tasks/toggle/:id(.:format)', to: 'tasks#toggle', as: 'task_toggle'
  delete 'tasks/completed', to: 'tasks#cleanup', as: 'cleanup_tasks'
  get '/tasks/by_project/:id(.:format)', to: 'tasks#by_project', as: 'tasks_by_project'
  get '/tasks/by_context/:id(.:format)', to: 'tasks#by_context', as: 'tasks_by_context'
  resources :tasks
  resources :projects

end
