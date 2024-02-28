Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  # resources :admin, only: :index
  
  #Merchant

  resources :merchants, only: [:show] do 
    # resources :dashboard, only: :index, action: :show, controller: "merchants"
    member { get "dashboard"}
    resources :items, only:[ :index, :show, :edit, :update,:new, :create]
    # resources :invoices, only: [:index, :show]
    resources :invoices, only: [:index, :show], :controller => "merchant_invoices"
    
  end
  
  
  
  
  

  namespace :admin do
    get "/", to: "dashboard#index"
    resources :merchants, only: [:index, :show, :edit, :update, :new, :create]
    resources :invoices, only: [:index, :show, :edit, :update]
  end
end
