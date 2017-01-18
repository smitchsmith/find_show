Rails.application.routes.draw do
  devise_for :users, controllers: { :omniauth_callbacks => "users/omniauth_callbacks" }
  root :to => "artists#index"

  resources :users, only: [] do
    get :unsubscribe, on: :member
  end
end
