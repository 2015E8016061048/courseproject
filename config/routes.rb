Rails.application.routes.draw do
  #get 'user/login'
  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'users#login'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  
  
  resources :devices
  resources :users
  resources :admins
 
  post '/createuser',to: 'users#createuser'
  get '/analyze',to: 'borrows#analyze'
  get '/manage',to: 'borrows#manage'
  get '/users/:id/history',to: 'users#history'
  get '/devices/:id/borrow', to: 'borrows#index'
  get '/devices/:id/giveback', to: 'borrows#giveback'
  get '/login' , to: 'users#login'
  get '/managerlogin',to: 'admins#login'
  put '/checklogin' , to: 'users#checklogin'
  put '/checkmanagerlogin' , to: 'admins#checklogin'
  get '/logout', to: 'users#logout'
  get '/managerlogout', to: 'admins#logout'
  get '/signup',to: 'users#signup'
  put '/borrow', to: 'borrows#borrow'
  get '/borrows', to: 'borrows#management'
  delete '/borrows/:id',to: 'borrows#destroy'
  put '/search',to: 'borrows#search'
  get '/managedevices',to: 'devices#managedevices'
 
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
