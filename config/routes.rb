Rails.application.routes.draw do
  resources :property_comments

  resources :card_infos

#  get 'auth/:provider/callback', to: 'sessions#create'
#  get 'logout', to: 'sessions#destroy'
  match '/users/:id/finish_signup' => 'users#finish_signup', via: [:get, :patch], :as => :finish_signup
  resources :admin_contacts

  resources :contact_messages

  resources :contact_requests do
    member do
      get :accept
      get :reject
      get :rental_agreement
      get :generate_rental_agreement
      get :agreement
    end

    collection do
      post :bulk
    end
  end

  devise_for :users, :controllers => { omniauth_callbacks: 'omniauth_callbacks' }

  resources :properties do
    collection do
      get :map
      post :map_block
      get :map_block
      get :translate_to_chinese
      get :invite_view
      get :temp_image
      get :get_properties
    end

    member do
      get :smart_post
      post :smart_post_invite
      get :custom_contact_form
      post :add_temp_invitee
      post :add_map_invitee
      post :remove_temp_invitee
      get :fileupload
      get :property_image
      patch :property_image
      delete :remove_image
      get :edit_step_1
      get :edit_step_2
      get :edit_step_3
      get :edit_step_4
    end
  end

  resources :users do
    member do
      get :change_language
    end
    collection do
      get :properties
      get :visits
      get :update_profile
    end
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'properties#index'

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
