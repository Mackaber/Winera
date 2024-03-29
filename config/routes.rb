Winera::Application.routes.draw do

  match '/landing', :to => redirect('/landing.html')
  get "/transaction/validate"

  match "/businesses/history", to: "businesses#history"
  match "/businesses/update_admin", to: 'businesses#update_admin'

  resources :businesses

  get "/main/index"
  get "/main/account"
  get "/main/login"

  #match '/index', :to => redirect('/landing.html')

  match "/transaction", to: 'transaction#index'
  #Despues de encontrar la tarjeta la pone en cards/show
  match "/card/confirm", to: 'cards#confirm'
  match "/card/register", to: 'cards#register'

  match "/transacciones/verificar/:card_code", to: 'cards#show'
  match "/card/:card_code", to: 'cards#show'
  match "/card", to: 'cards#show'

  match "/transaction/use_era_points", to: 'transaction#use_era_points'
  #match 'auth/:provider/callback', to: 'sessions#create'
  #match 'auth/failure', to: redirect('/')
  #match 'signout', to: 'sessions#destroy', as: 'signout'

  devise_for :users, controllers: {omniauth_callbacks: "omniauth_callbacks", registrations: "registrations"} do
    get '/users/sign_in' => 'devise/sessions#create'
    get '/users/sign_out' => 'devise/sessions#destroy'
    #match '/referer/:ref_id'  => 'registrations#new'
  end

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/landing.html.

  match '', to: 'main#login', constraints: {subdomain: 'negocios'}
  root :to => 'main#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
