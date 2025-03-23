Rails.application.routes.draw do
  resources :movies do
    member do
      post 'image' # Upload image for a specific movie
    end

    collection do
      get 'statuses' # Fetch movie statuses
    end
  end
  resources :tvshows do
    member do
      post 'image' # Upload image for a specific tvshow
    end

    collection do
      get 'statuses' # Fetch tvshow statuses
    end
  end
  resources :persons do
    collection do
      get 'roles' # Fetch person roles
    end
  end

  resources :tvshows
  resources :genres
  resources :persons
  resources :admins, only: [:create]
end
