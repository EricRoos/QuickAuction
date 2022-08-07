class CanAccessFlipperUI
  def self.matches?(request)
    current_user = request.env['warden'].user
    current_user.is_a?(AdminUser)
  end
end
Rails.application.routes.draw do
  resources 'support_tickets', only: %i[new create]

  get 'errors/not_found'
  get 'errors/not_authorized'
  constraints CanAccessFlipperUI do
    mount Flipper::UI.app(Flipper) => '/flipper'
  end
  mount FinePrint::Engine => "/fine_print"

  resources :interested_people
  resources :help_articles

  resource 'help_articles', only: %i[show]

  get 'blog/:slug', to: 'blog#show', as: :blog
  get 'inbox', to: 'inbox#index'
  get 'inbox/:notification_id', to: 'inbox#show', as: :inbox_message

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :auction_items, except: [:edit ] do
    resources :auction_offers, except: [:edit], shallow: true
  end

  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")

  match "/401", to: "errors#not_authorized", via: :all
  match "/404", to: "errors#not_found", via: :all
  get '/service-worker.js', to: 'service_worker#show'
  get '/:landing_page_id', to: 'landing_page#show', as: 'landing_page'


  root 'landing_page#show'
end
