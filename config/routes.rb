Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
  }
  devise_scope :user do
    get 'sending_destinations', to: 'users/registrations#newSendingDestination'
    post 'sending_destinations', to: 'users/registrations#createSendingDestination'
  end
  root "items#index"

  resources :items, only: [:new, :create, :update, :show, :edit, :destroy] do
    collection do
      get 'get_category_child', to: 'items#get_category_child', defaults: { format: 'json' }
      get 'get_category_grandchild', to: 'items#get_category_grandchild', defaults: { format: 'json' }
    end
  end
  resources :mypage, only: [:index]
  resources :logout, only: [:index]
  resources :cards, only: [:index, :new, :create, :show, :destroy]
  resources :purchase, only: [:show] do
    collection do
      post 'pay', to: 'purchase#pay'
    end
  end
end