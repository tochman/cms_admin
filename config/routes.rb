CmsAdmin::Engine.routes.draw do
  devise_for :users, controllers: {sessions: 'sessions'}
  root 'dashboard#index'
  resources :events
  resources :news
  resources :users
end
