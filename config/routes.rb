Rails.application.routes.draw do
  devise_for :users
  resources :tasks
  get '/tasks/toggle/:id(.:format)', to: 'tasks#toggle', as: 'task_toggle'
  root 'tasks#index'
end
