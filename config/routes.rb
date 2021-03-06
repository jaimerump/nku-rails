NkuRails::Application.routes.draw do
  get "attendences/index"
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
 
   # Upload routes
  get 'students/upload', to: "students#upload", as: :students_upload
  post 'students/upload', to: "students#process_upload", as: :students_process_upload
  get 'assignments/upload', to: "assignments#upload", as: :assignments_upload
  post 'assignments/upload', to: "assignments#process_upload", as: :assignments_process_upload
  
  resources :students do
    resources :attendances
    resources :assignments
  end
  
  resources :attendances do
  end
  
  resources :assignments
  
  # Login/logout routes
  get 'login', to: "login#index", as: :login_page
  post 'login/process', to: "login#login", as: :login_process
  get 'logout', to: "login#logout", as: :logout
  
  # Seating Chart
  get 'seating', to: "seating#index", as: :seating_chart
  
  root 'students#index'

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
