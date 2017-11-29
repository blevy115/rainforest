Rails.application.routes.draw do
  resource :sessions, only: %i(create new destroy)
  resource  :users,    only: %i(create new)

  root 'products#index'

  resources :products do
    resources :reviews, except: [:index, :new, :show]
  end

end
