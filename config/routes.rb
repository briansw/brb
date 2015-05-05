Rails.application.routes.draw do

  admin_for :users
  admin_for :images, private: true

  namespace :admin do
    get  'login',  to: 'sessions#new'
    post 'login',  to: 'sessions#create'
    get  'logout', to: 'sessions#destroy'
  end

  get 'login', to: redirect('/admin/login')

end
