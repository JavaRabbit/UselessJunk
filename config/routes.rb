# current_user will forever mean the currently logged user

Rails.application.routes.draw do

  get "signup",                   to: "users#new",           as: "signup"
  get "login",                    to: "sessions#new",        as: "login"
  get "logout",                   to: "sessions#destroy",    as: "logout"
  get "/users/:id/confirm",       to: "users#confirm",       as: :confirm
  get "/users/:id/orders",        to: "users#my_orders",     as: :my_orders
  post "/users/:id/orders/",      to: "users#filter_orders"
  resources :users
  resources :sessions
  # resources creates 7 routes that map to the users controller: index, new, create
  # show, edit, update, destroy
  # http://guides.rubyonrails.org/routing.html

  get "/products/new",            to: "products#new",         as: :new_product
  post "/products/new",           to: "products#create"
  get "/products/:id",            to: "products#show",        as: :product
  get "/products/:id/edit",       to: "products#edit"
  put "/products/:id/edit",       to: "products#update",      as: :edit_product
  delete "/products/:id",         to: "products#destroy",     as: :delete_product

  get "/order_items",             to: "order_items#index",    as: :order_items

  # this page will show only the logged user's order_items
  patch "/update_cart",           to: "order_items#update",   as: :update_cart

  get "/reviews",                 to: "reviews#index",        as: :reviews
  post "/reviews/",               to: "reviews#create",       as: :new_review

  get "/orders/:id",              to: "orders#show",          as: :order
  post "/orders/new",             to: "orders#add_to_cart",   as: :new_order
  patch "/orders/:id/edit",       to: "orders#update",        as: :edit_order
  get "/orders/:id/buy",          to: "orders#buy",           as: :buy_order
  put "/orders/:id",              to: "orders#pay",           as: :pay_for_order
  get "/orders/:id/confirm",      to: "orders#confirm",       as: :order_confirm

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
