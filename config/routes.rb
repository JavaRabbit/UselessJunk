# @logged_user will forever mean the currently logged user

Rails.application.routes.draw do

  get "/users/new",               to: "users#create",       as: :create_user
  get "/users/login",             to: "users#login",        as: :user_login
  put "/users/:id/edit",         to: "users#update"
  get "/users/new",               to: "users#new",          as: :new_users
  post "/users/new",              to: "users#create"
  get "/users/:id",               to: "users#show",         as: :user
  get "/users/:id/edit",          to: "users#edit",         as: :edit_user
  get "/users/:id/delete",         to: "users#delete",        as: :temp
  delete "/users/:id",             to: "users#destroy",      as: :delete_user

  get "/products/new",            to: "products#new",       as: :new_product
  post "/products/new",           to: "products#create"

  get 'sessions/new'

  get "signup",                   to: "users#new",           as: "signup"
  get "login",                    to: "sessions#new",        as: "login"
  get "logout",                   to: "sessions#destroy",    as: "logout"
  #get "/users/:id",               to: "users#show",         as: :user
  #get "/users/:id/edit",          to: "users#edit",         as: :edit_user
  #delete "users/:id/delete",      to: "users#delete",       as: :delete_user
  #patch "users/:id/edit",         to: "users#update"

  resources :users
  resources :sessions

  get "/products/:id",            to: "products#show",      as: :product
  get "/products/:id/edit",        to: "products#edit",      as: :edit_product
  delete "/products/:id",          to: "products#destroy",   as: :delete_product

  get "/order_items",             to: "order_items#index",  as: :order_items
  #this page will show only the logged user's order_items

  patch "/update_cart",           to: "order_items#update",  as: :update_cart

  get "/reviews",                 to: "reviews#index",      as: :reviews
  post "/reviews/",               to: "reviews#create",     as: :new_review

  get "/orders/:id",              to: "orders#show",        as: :order
  post "/orders/new",             to: "orders#add_to_cart", as: :new_order
  patch "/orders/:id/edit",       to: "orders#update",      as: :edit_order

  root "products#index"

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
