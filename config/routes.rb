Rails.application.routes.draw do
  
  namespace :admin do
    get  'login',  to: 'sessions#new'
    post 'login',  to: 'sessions#create'
    get  'logout', to: 'sessions#destroy'
    
    resource :images
  end
  
  get 'login', to: redirect('/admin/login')
  
end
