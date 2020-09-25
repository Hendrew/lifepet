Rails.application.routes.draw do
  root 'home#index'
  resources :animal_kinds, except: :show
  resources :animals
end
