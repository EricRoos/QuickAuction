Rails.application.routes.draw do
  resources :auction_items, except: [:edit ] do
    resources :auction_offers, except: [:edit], shallow: true
  end
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "auction_items#index"
end
