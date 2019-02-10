Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resource :session, only: [:create, :destroy]

  resources :users, except: [:new, :edit] do
    get :current, on: :collection
    resources :trades, except: [:new, :edit]
  end


  
end
