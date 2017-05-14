Rails.application.routes.draw do
  root 'rounds#index'
  get 'rounds/index'
  
  resources :players
end
