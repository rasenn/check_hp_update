MangaChecker::Application.routes.draw do

  #root :to => "check_update#index"
  root :to => "check_update#index"
  get "check_update/logout"
  get "check_update/index"
  get "check_update/show"
  get "check_update/add_url_form"
  get "check_update/check_updates"
  get "check_update/delete"
  get "check_update/delete_list"
  post "check_update/add_url"
  get "check_update/add_url"
  get "home/index"
  get "check_update/redirect"
  get "check_update/ranking"

  devise_for :users
  resources :posts
  match "posts/:id/categ" => "posts#categ"
  match "posts/:id/tag_posts" => "posts#tag_posts"
  match "posts/searcharchive" => "posts#searcharchive"
  resources :categories
  resources :comments
  resources :countpages
  #root :to => "posts#index"

    




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
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'



end
