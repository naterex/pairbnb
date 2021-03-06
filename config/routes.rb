Rails.application.routes.draw do

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  constraints Clearance::Constraints::SignedIn.new do
    root to: 'listings#homepage', as: :signed_in_root
  end

  constraints Clearance::Constraints::SignedOut.new do
    root to: 'listings#homepage'
  end

  resources :listings

  resources :reservations, only: [:new, :create, :show, :index, :destroy]

  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "sessions", only: [:create]

  resources :users,
    only: [:create, :show, :edit, :update, :destroy] do
      resource :password,
        controller: "clearance/passwords",
        only: [:create, :edit, :update]
    end

  get "/sign_in" => "clearance/sessions#new", as: "sign_in"
  get "/auth/:provider/callback" => "sessions#create_from_omniauth"

  delete "/sign_out" => "sessions#destroy", as: "sign_out"

  if Clearance.configuration.allow_sign_up?
    get "/sign_up" => "clearance/users#new", as: "sign_up"
  end


  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
