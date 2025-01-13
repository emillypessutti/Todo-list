Rails.application.routes.draw do
  resources :lists, except: :new do
    resources :items, only: [ :edit, :create, :update, :destroy]
  end

  root "lists#index"
end

