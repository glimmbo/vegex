Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  resource :session, only: [:create, :destroy]
  
  resources :users do
    get :current, on: :collection
  end
  
  resources :trades do
    get :open, on: :collection
    get :my, on: :collection
    resources :offers
  end
  
end
