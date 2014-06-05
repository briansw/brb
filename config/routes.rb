Rails.application.routes.draw do
  
  concern :taggable do
    collection do
      get :tags
    end
  end
  
  namespace :admin do
    root to: 'issues#index'
    resources :users
    resources :images
    resources :article_types
    resources :articles, concerns: [:taggable]
    resources :authors
    resources :issues
    resources :tags
    resources :news
    
    get  'login',  to: 'sessions#new'
    post 'login',  to: 'sessions#create'
    get  'logout', to: 'sessions#destroy'
  end
  
  get 'login', to: redirect('/admin/login')
  
end
