Rails.application.routes.draw do
  devise_for :users
  root 'top#index'

  resources :rooms, only: [:new, :create, :show], param: :token
end
