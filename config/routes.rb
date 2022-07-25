Rails.application.routes.draw do
  get 'inbox', to: 'inbox#index'
  get 'inbox/:notification_id', to: 'inbox#show', as: :inbox_message

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :auction_items, except: [:edit ] do
    resources :auction_offers, except: [:edit], shallow: true
  end

  if (Flipper.enabled?(:public_access) rescue false)
    devise_for :users
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  get '/service-worker.js', to: 'service_worker#show'
  get '/:landing_page_id', to: 'landing_page#show'
  root 'landing_page#show'
end
