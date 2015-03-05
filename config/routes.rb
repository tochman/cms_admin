CmsAdmin::Engine.routes.draw do
  devise_for :users, controllers: {sessions: 'sessions'}
  root 'dashboard#index'
  resources :events
  resources :news
  resources :users
  #get '*not_found', to: 'application#render_404'
  #get '*not_found', to: 'errors#error_404'
end
