Rails.application.routes.draw do
  devise_for :users, controllers: { :omniauth_callbacks => "users/omniauth_callbacks" }

  devise_scope :user do
    root to: "devise/sessions#new"
  end

  resources :users, only: [] do
    get :unsubscribe, on: :member
  end

  resource :current_user, :only => [:show, :edit, :update], path: "account"

  get "welcome", :to => "welcome#show"
end
