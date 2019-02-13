Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resource :session, only: [:create, :destroy]

  resources :users, except: [:new, :edit] do
    get :current, on: :collection
    # resources :my_trades, except: [:new, :edit]
  end

  resources :trades do
    get :open, on: :collection # /offers
    get :my, on: :collection # /my_trades
  end


  
end
