Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
  }
  devise_scope :user do
    get 'sending_destinations', to: 'users/registrations#newSendingDestination'
    post 'sending_destinations', to: 'users/registrations#createSendingDestination'
  end
  root "items#index"
  resources :items,only: [:new, :create, :update]
  resources :mypage, only: [:index]
  resources :logout, only: [:index]
end