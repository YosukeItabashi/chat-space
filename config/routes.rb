Rails.application.routes.draw do
  devise_for :users
  root 'messages#index'
  resources :users, only: [:edit, :update]
  get 'groups' => 'groups#new'
  resources :groups, except: [:destroy, :show, :index] do
    resources :messages, only: [:index]
  end
end
