Rails.application.routes.draw do
  devise_for :users
  resources :users

  resources :chats do
    resources :messages, only: [:create]  
  end

  resources :messages, only: [:index, :show, :new, :create, :edit, :update]


  root to: 'users#index'
end


