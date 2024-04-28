Rails.application.routes.draw do
  scope(path: '"/services"') { draw :storefront }
  # This line mounts Solidus's routes at the root of your application.
  #
  # Unless you manually picked only a subset of Solidus components, this will mount routes for:
  #   - solidus_backend
  #   - solidus_api
  # This means, any requests to URLs such as /admin/products, will go to Spree::Admin::ProductsController.
  #
  # If you are using the Starter Frontend as your frontend, be aware that all the storefront routes are defined
  # separately in this file and are not part of the Solidus::Core::Engine engine.
  #
  # If you would like to change where this engine is mounted, simply change the :at option to something different.
  # We ask that you don't use the :as option here, as Solidus relies on it being the default of "spree"
  mount Spree::Core::Engine, at: '"/services"'
  get 'home/index'
  resources :progresses
  # get "vendor/index", 
  # get "visitor/index"
  # Define Devise routes
  devise_for :users

  # root to: "devise/sessions#new"
  # root to: "visitor#index"


  # Define routes for authenticated users
  authenticated :user, ->(u) { u.vendor? } do
    root to: 'vendor#index', as: :vendor_root
  end
  
  authenticated :user, ->(u) { u.visitor? } do
    root to: 'visitor#index', as: :visitor_root
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
