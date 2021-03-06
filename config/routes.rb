Rails.application.routes.draw do



  resources :findconnections
  resources :profiles , :except => [:new,:create]
  get 'welcome/index'
  post 'api/v1/profiles/updateprofile'  => "api/v1/profiles#updateprofile"
   post 'api/v1/profiles/updateprofileimage'  => "api/v1/profiles#updateprofileimage"
  post 'api/v1/profiles/getprofile'  => "api/v1/profiles#getprofile"
  post 'api/v1/profiles/showconnectionprofile'  => "api/v1/profiles#showconnectionprofile"
  post 'api/v1/findconnections/addfriendrequest' => "api/v1/findconnections#addfriendrequest"
  post 'api/v1/findconnections/getfriendrequeststatus' => "api/v1/findconnections#getfriendrequeststatus"
  post 'api/v1/findconnections/getotherfriendrequeststatus' => "api/v1/findconnections/getotherfriendrequeststatus"
  post 'api/v1/findconnections/approveotherfriendrequeststatus' => "api/v1/findconnections/approveotherfriendrequeststatus"                                                   
  post 'api/v1/findconnections/removeotherfriendrequeststatus' => "api/v1/findconnections/removeotherfriendrequeststatus"


 #devise_scope :user do     
  #  post "/api/v1/users" => "api/v1/users#create"
  #end




  namespace :api, defaults:{format: 'json'} do
    namespace :v1 do
      resources :profiles
      resources :products
      resources :findconnections

   end
  end

  



  resources :products
  devise_for :users, :controllers => {:registrations => "users/registrations",:sessions => "users/sessions"}
 
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
   root 'welcome#index'

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
