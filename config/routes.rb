Rails.application.routes.draw do
  resources :users

  resources :chats do
    resources :messages, only: [:create]  
  end

  resources :messages, only: [:index, :show, :new, :create, :edit, :update]


  root to: 'users#index'
end


