Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions' 
  }
  
  root 'top#index'
  get  'about',   to: 'top#about'
  
  resources :rooms, only: [:new, :create, :show], param: :token do
    get 'room_setting', to: 'room_setting#index'
  end

  resource :member_requests, only: [:create, :destroy]

end
