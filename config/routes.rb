Rails.application.routes.draw do
  root to: 'buses#index'
  devise_for :users, controllers: { registrations: 'users/registrations' }
  
  resources :reservations, only: [:index] do
    get 'cancel', on: :member
    get 'show_seats', on: :collection 
  end

  resources :buses do
	  resources :reservations, only: [:new, :create, :destroy]
  end

  namespace :admin do
    resources :reservations, only: [:index]
    resources :buses, only: [:index] do
        resources :reservations, only: [:index]
    end
    resources :owners, only: [:index, :show, :destroy] do
      member do 
        put 'approve'
        put 'suspend'
      end
      resources :reservations, only: [:index]
      resources :buses, only: [:index] do
        resources :reservations, only: [:index]
      end
    end
  end

  namespace :owner do
    resources :reservations, only: [:index]
    resources :buses do
      resources :reservations, only: [:index]
    end
  end

 
  #devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
