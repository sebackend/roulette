Rails.application.routes.draw do
  root 'players#index'
  get 'rounds/index'
  
  resources :players
end
