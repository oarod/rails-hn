Rails.application.routes.draw do
  root to: 'stories#index'

  resources :stories, only: [:index, :show]
end
