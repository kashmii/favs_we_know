Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions' 
  }
  
  root 'top#index'
  get  'about',   to: 'top#about'
  
  resources :rooms, only: [:new, :create, :show], param: :token do
    get 'room_setting', to: 'room_setting#index'
    resources :fund_restaurants, only: [:show, :new, :create, :destroy]
  end

  resource :member_requests, only: [:create, :destroy]

end
