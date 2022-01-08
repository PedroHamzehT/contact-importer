Rails.application.routes.draw do
  root 'contacts#index'

  resources :users, only: %i[new create]

  resources :sessions, only: %i[new create destroy]

  resources :contacts, only: %i[index]
end
