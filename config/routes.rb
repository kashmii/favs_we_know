Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions' 
  }
  
  root 'top#index'
  get  'about',   to: 'top#about'
  
  resources :rooms, param: :token do
    get 'setting', to: 'room_setting#index'
    resources :restaurants, controller: 'room/restaurants'
    resources :reports, controller: 'room/reports'
  end

  resources :member_requests, only: [:create, :destroy] do
    member do
      post :allow
      post :deny
    end
  end
  resources :notifications, only: [:index, :create, :destroy] do
    member do
      post :checked
    end
  end

end
