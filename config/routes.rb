# @logged_user will forever mean the currently logged user

Rails.application.routes.draw do


  root "products#index"
  get "/users/new",               to: "users#create",       as: :create_user
  get "/users/login",             to: "users#login",        as: :user_login
  get "/users/:id",               to: "users#show",         as: :user
  get "/users/:id/edit",          to: "users#edit",         as: :edit_user
  get "users/:id/delete",         to: "users#delete",        as: :temp
  patch "users/:id/edit",         to: "users#update"
  get "/users/new",               to: "users#new",          as: :new_users
  post "/users/new",              to: "users#create"
  delete "users/:id",             to: "users#destroy",      as: :delete_user

  post "/users/signin",           to: "users#signin",       as: :users
  get "/users/logout",            to: "users#logout",       as: :user_logout
  post "/users/logout",           to: "users#destroy"
  get "/products/:id",            to: "products#show",      as: :product
  get "products/:id/edit",        to: "products#edit",      as: :edit_product
  delete "products/:id",          to: "products#destroy",   as: :delete_product
  get "/products",                to: "products#index"
  post "/products/new",           to: "products#create"
  get "products/new",             to: "products#new",       as: :new_product

  get "/order_items",             to: "order_items#index",  as: :order_items
  #this page will show only the logged user's order_items

  get "/reviews",                 to: "reviews#index",      as: :reviews
  post "/reviews/",               to: "reviews#create",     as: :new_review



  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
