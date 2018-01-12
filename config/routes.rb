Rails.application.routes.draw do
  root to: 'stories#index'

  get 'news', to: 'stories#index', category: 'news'
  get 'newest', to: 'stories#index', category: 'newest'
  get 'show', to: 'stories#index', category: 'show'
  get 'ask', to: 'stories#index', category: 'ask'
  get 'jobs', to: 'stories#index', category: 'jobs'

  resources :stories, only: [:index, :show]
end
