Rails.application.routes.draw do
  root 'contacts#index'

  resources :users, only: %i[new create]

  resources :sessions, only: %i[new create] do
    collection do
      delete '', to: 'sessions#destroy'
    end
  end

  resources :contacts, only: %i[index]

  resources :imports, only: %i[index new create] do
    member do
      get '/fails', to: 'imports#fails'
    end
  end
end
