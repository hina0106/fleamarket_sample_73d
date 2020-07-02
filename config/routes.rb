Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
  }
  devise_scope :user do
    get 'sending_destinations', to: 'users/registrations#new_sending_destination'
    post 'sending_destinations', to: 'users/registrations#create_sending_destination'
  end
  get 'items/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "items#index"
end
