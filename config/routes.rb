CmsAdmin::Engine.routes.draw do
  devise_for :users, controllers: {sessions: 'sessions'}

  get '', to: 'dashboard#index', as: '/'
  resources :events
  resources :news
  resources :users
end
